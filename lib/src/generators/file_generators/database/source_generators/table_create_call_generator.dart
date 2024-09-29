import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:sqlparser/sqlparser.dart';

/// Converts sql table name into a table create call.
class TableCreateCallGenerator {
  /// Converts sql table name into a table create call.
  ///
  /// It takes [statement] as parameter and returns a `String`.
  ///
  /// - `statement`: Parsed sql table create statement
  ///
  /// Returns a `String` formatted as
  /// `(int version) => [TABLECREATESCRIPTNAMECreate]`.
  String call(CreateTableStatement statement) {
    final className = TableNameToConstNameConverter()
        .convert(statement.tableName);
    return '(int version) => [${className}Create]';
  }
}
