import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/column_to_const_definition_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates const definition for all columns in table
class ColumnsToConstDefinitionsGenerator {
  /// Generates const name for table from given [statement]
  ///  'statement': Table statement
  ///
  /// Returns [String] containing the const name of the table name
  String call(CreateTableStatement statement) {
    final constGenerator =
      ColumnToConstDefinitionGenerator();
    final sb = StringBuffer();
    for (final columnDefinition in statement.columns) {
      sb.writeln(constGenerator(statement, columnDefinition));
    }

    return sb.toString().trimRight();
  }
}
