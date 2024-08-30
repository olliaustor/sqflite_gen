import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates const name for table
class TableToConstNameGenerator {
  /// Generates const name for table from given [statement]
  ///  'statement': Table statement
  ///
  /// Returns [String] containing the const name of the table name
  String call(CreateTableStatement statement) {
    final tableFieldName = statement.toFieldName();

    final result = '${tableFieldName}Table';

    return result;
  }
}
