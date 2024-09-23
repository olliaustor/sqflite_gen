import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates map assignment for column with auto increment flag
class ColumnsAutoIncrementAssignmentGenerator {
  /// Placeholder for property name
  final placeholderPropertyName = '%placeholderPropertyName%';

  /// Placeholder for map column name
  final placeholderColumnName = '%placeholderColumnName%';

  /// Assignment snippet with placeholder
  final primaryKeyAssignmentContent = '''

    if (%placeholderPropertyName% != null) {
      map[%placeholderColumnName%] = %placeholderPropertyName%;
    }
''';

  /// Generates specific auto increment column assignment for given
  /// [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing the assignment or empty string if no auto
  /// increment column is available
  String call(CreateTableStatement statement) {
    final autoIncrementColumn = statement.columns
        .where((column) => column.isAutoIncrement())
        .firstOrNull;

    if (autoIncrementColumn == null) {
      return '';
    }

    final columnPropertyName = autoIncrementColumn.toFieldName();
    final columnConstName =
        ColumnNameToConstNameConverter(statement.tableName).convert(
      autoIncrementColumn.toFieldName(),
    );

    return primaryKeyAssignmentContent
        .replaceAll(placeholderPropertyName, columnPropertyName)
        .replaceAll(placeholderColumnName, columnConstName);
  }
}
