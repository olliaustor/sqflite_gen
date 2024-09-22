import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates method update for table
class TableToMethodUpdateGenerator {
  /// Placeholder for class name
  final String placeholderClassName = '%className%';

  /// Placeholder for field name
  final String placeholderFieldName = '%fieldName%';

  /// Placeholder for column field name of primary column
  final String placeholderPrimaryColumnFieldName = '%primaryColumnFieldName%';

  /// Placeholder for column const name of primary column
  final String placeholderPrimaryColumnNameConst = '%primaryColumnNameConst%';

  /// Placeholder for const name which represents the sql table name
  final String placeholderTableNameConst = '%tableNameConst%';

  /// Content containing replacement values
  final content = r'''
  Future<bool> update(%className% %fieldName%) async {
    final result = db.update(%tableNameConst%, %fieldName%.toMap(),
      where: '\$%primaryColumnNameConst% = ?',
      whereArgs: [%fieldName%.%primaryColumnFieldName%],);
      
    return result > 0;  
  }
''';

  /// Generates update method from given [CreateTableStatement]
  ///  'statement': table statement
  ///
  /// Returns [String] containing the update method
  String call(CreateTableStatement statement) {
    if (_getPrimaryColumn(statement) == null) {
      return '';
    }

    final text = content
        .replaceAll(placeholderFieldName, statement.toFieldName())
        .replaceAll(placeholderClassName, statement.toClassName())
        .replaceAll(
          placeholderTableNameConst,
          TableNameToConstNameConverter().convert(
            statement.tableName,
          ),
        )
        .replaceAll(
          placeholderPrimaryColumnFieldName,
          _getPrimaryColumnNameField(
            statement,
          ),
        )
        .replaceAll(
          placeholderPrimaryColumnNameConst,
          _getPrimaryColumnNameConst(
            statement,
          ),
        );

    return text;
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

  /// Returns
  ///  'statement': table statement
  ///
  /// Returns [String] containing the return statement
  String _getPrimaryColumnNameConst(CreateTableStatement statement) {
    final primaryKeyColumn = _getPrimaryColumn(statement);

    return primaryKeyColumn == null
        ? 'unknown'
        : ColumnNameToConstNameConverter(statement.tableName)
            .convert(primaryKeyColumn.columnName);
  }
}
