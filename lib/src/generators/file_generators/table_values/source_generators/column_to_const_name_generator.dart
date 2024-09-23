import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates const name for column
class ColumnToConstNameGenerator {
  /// Generates const name for column from given [statement] and
  /// [columnDefinition]
  ///  'statement': Table statement
  ///  [columnDefinition]: Column definition
  ///
  /// Returns [String] containing the const definition of the column name
  String call(
    CreateTableStatement statement,
    ColumnDefinition columnDefinition,
  ) {
    final fieldNameConverter = UnderscoreToCamelCaseConverter();
    final tableFieldName = statement.toFieldName();
    final columnFieldName = fieldNameConverter.convert(
      columnDefinition.columnName,
    );

    final result = '${tableFieldName}Column$columnFieldName';

    return result;
  }
}
