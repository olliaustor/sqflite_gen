import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/table_to_const_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates const create name for table
class TableToConstCreateNameGenerator {
  /// Generates const create name for table from given [statement]
  ///  'statement': Table statement
  ///
  /// Returns [String] containing the const create name of the table name
  String call(CreateTableStatement statement) {
    final constGenerator = TableToConstNameGenerator();

    final result = '${constGenerator(statement)}Create';

    return result;
  }
}
