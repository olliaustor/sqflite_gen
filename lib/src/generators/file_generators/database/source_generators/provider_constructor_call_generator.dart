import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Converts sql table name into a table provider constructor call.
class ProviderConstructorCallGenerator {
  /// Converts sql table name into a table provider constructor call.
  ///
  /// It takes [statement] as parameter and returns a `String`.
  ///
  /// - `statement`: Parsed sql table create statement
  ///
  /// Returns a `String` formatted as `TABLENAMEProvider(db)`.
  String call(CreateTableStatement statement) {
    final className = statement.toClassName();
    return '${className}Provider(db)';
  }
}