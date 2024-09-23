import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates method delete for table
class TableToMethodDeleteGenerator {
  /// Placeholder for field type
  final String placeholderFieldType = '%fieldType%';

  /// Placeholder for column field name of primary column
  final String placeholderPrimaryColumnFieldName = '%primaryColumnFieldName%';

  /// Placeholder for column const name of primary column
  final String placeholderPrimaryColumnNameConst = '%primaryColumnNameConst%';

  /// Placeholder for const name which represents the sql table name
  final String placeholderTableNameConst = '%tableNameConst%';

  /// Content containing replacement values
  final content = r'''
  Future<bool> delete(%fieldType% %primaryColumnFieldName%) async {
    final result = await db.delete(%tableNameConst%,
      where: '\$%primaryColumnNameConst% = ?',
      whereArgs: [%primaryColumnFieldName%],);
      
    return result > 0;  
  }
''';

  /// Generates delete method from given [CreateTableStatement]
  ///  'statement': table statement
  ///
  /// Returns [String] containing the delete method
  String call(CreateTableStatement statement) {
    if (_getPrimaryColumn(statement) == null) {
      return '';
    }

    final text = content
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
          placeholderFieldType,
          _getPrimaryColumnNameType(
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
  String _getPrimaryColumnNameType(CreateTableStatement statement) {
    final primaryKeyColumn = _getPrimaryColumn(statement);

    return primaryKeyColumn == null
        ? 'unknown'
        : primaryKeyColumn.toFieldType().replaceAll('?', '');
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
