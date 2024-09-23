import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/table_to_const_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates const definition for table
class TableToConstDefinitionGenerator {
  /// Generates const definition for table from given [statement]
  ///  'statement': Table statement
  ///
  /// Returns [String] containing the const definition of the table name
  String call(CreateTableStatement statement) {
    final constNameGenerator = TableToConstNameGenerator();
    final tableSqlName = statement.tableName;
    final constName = constNameGenerator(statement);

    final result = "const String $constName = '$tableSqlName';";

    return result;
  }
}
