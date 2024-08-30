import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/column_to_const_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates const definition for column
class ColumnToConstDefinitionGenerator {
  /// Generates const definition for table from given [statement] and
  /// [columnDefinition]
  ///  'statement': Table statement
  ///
  /// Returns [String] containing the const definition of the table name
  String call(
      CreateTableStatement statement, ColumnDefinition columnDefinition) {
    final constNameGenerator = ColumnToConstNameGenerator();
    final columnSqlName = columnDefinition.columnName;
    final constName = constNameGenerator(statement, columnDefinition);

    final result = "const String $constName = '$columnSqlName';";

    return result;
  }
}
