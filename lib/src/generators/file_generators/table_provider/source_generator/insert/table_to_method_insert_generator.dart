import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates method insert for table
class TableToMethodInsertGenerator {
  /// Placeholder for class name
  final String placeholderClassName = '%className%';

  /// Placeholder for field name
  final String placeholderFieldName = '%fieldName%';

  /// Placeholder for column field name of primary column
  final String placeholderPrimaryColumnFieldName = '%primaryColumnFieldName%';

  /// Placeholder for const name which represents the sql table name
  final String placeholderTableNameConst = '%tableNameConst%';

  /// Placeholder for return statement
  final String placeholderReturn = '%placeholderReturn%';

  /// Content for returning new object from copy with call
  final returnCopyWithCall =
      'return %fieldName%.copyWith(%primaryColumnFieldName%: result);';

  /// Content for returning new object from copy with call and nullable value
  final returnCopyWithCallNullable =
      'return %fieldName%.copyWith(%primaryColumnFieldName%: Wrapped.value(result));';

  /// Content for returning the received object
  final returnDefault = 'return %fieldName%;';

  /// Content containing replacement values
  final content = '''
  Future<%className%> insert(%className% %fieldName%) async {
    final result = await db.insert(%tableNameConst%, %fieldName%.toMap());
    
    %placeholderReturn%
  }
''';

  /// Generates insert method from given [CreateTableStatement]
  ///  'statement': table statement
  ///
  /// Returns [String] containing the insert method
  String call(CreateTableStatement statement) {
    final text = content
        .replaceAll(placeholderFieldName, statement.toFieldName())
        .replaceAll(placeholderClassName, statement.toClassName())
        .replaceAll(placeholderReturn, _getReturnStatement(statement))
        .replaceAll(
          placeholderTableNameConst,
          TableNameToConstNameConverter().convert(
            statement.tableName,
          ),
        );

    return text;
  }

  /// Generates return statement based on whether the table has a primary int
  /// key or not
  ///  'statement': table statement
  ///
  /// Returns [String] containing the return statement
  String _getReturnStatement(CreateTableStatement statement) {
    return _hasIntegerPrimaryColumn(statement)
        ? _getReturnCopyWithCall(statement)
        : _getReturnDefault(statement);
  }

  /// Generates return default statement in case the table does not have a
  /// primary int key
  ///  'statement': table statement
  ///
  /// Returns [String] containing the return statement
  String _getReturnDefault(CreateTableStatement statement) {
    return returnDefault.replaceAll(
        placeholderFieldName, statement.toFieldName());
  }

  /// Generates return statement in case the table does have a primary int key
  ///  'statement': table statement
  ///
  /// Returns [String] containing the return statement with a clone of the
  /// given object including the id from the newly created record
  String _getReturnCopyWithCall(CreateTableStatement statement) {
    final content = _getPrimaryColumn(statement)!.isNonNullable
      ? returnCopyWithCall
      : returnCopyWithCallNullable;

    return content
        .replaceAll(placeholderFieldName, statement.toFieldName())
        .replaceAll(
          placeholderPrimaryColumnFieldName,
          _getPrimaryColumnNameField(statement),
        );
  }

  /// Find the primary column of the given table
  ///  'statement': table statement
  ///
  /// Returns [ColumnDefinition] if table contains a primary key null otherwise
  ColumnDefinition? _getPrimaryColumn(CreateTableStatement statement) {
    return statement.columns
        .where((column) => column.isPrimaryKey())
        .firstOrNull;
  }

  /// Returns
  ///  'statement': table statement
  ///
  /// Returns [String] containing the return statement
  String _getPrimaryColumnNameField(CreateTableStatement statement) {
    final primaryKeyColumn = _getPrimaryColumn(statement);

    return primaryKeyColumn == null
        ? 'unknown'
        : primaryKeyColumn.toFieldName();
  }

  bool _hasIntegerPrimaryColumn(CreateTableStatement statement) {
    final primaryKeyColumn = _getPrimaryColumn(statement);
    return primaryKeyColumn != null &&
      primaryKeyColumn.toFieldType().startsWith('int');
  }
}
