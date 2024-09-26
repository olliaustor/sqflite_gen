import 'package:sqflite_gen/src/converters/converter_base.dart';
import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';

/// Converts given sql table name and column name to const name
class ColumnNameToConstNameConverter extends Converter {
  /// Creates new object. [sqlTableName] expected the name of the sql table.
  ColumnNameToConstNameConverter(this.sqlTableName);

  /// Formatter to ensure CamelCase notation
  final CamelCaseFormatter camelCaseFormatter = CamelCaseFormatter();

  /// Used sql table name (part of resulting string)
  final String sqlTableName;

  /// Creates a new string in which the given [String] in [source]
  /// is combined with the [sqlTableName] to reflect a const name which can be
  /// used in generated code.
  /// ```dart
  /// converter = ColumnNameToConstNameConverter('customer_details');
  /// 'converter'.convert('first_name'); // 'customerDetailsColumnFirstName'
  /// ```
  /// Notice that the resulting string will always be in camelcase to be
  /// compliant with dart syntax.
  @override
  String convert(String source) {
    final tableName = camelCaseFormatter.format(
      sqlTableName,
      startsWithUpperCase: false,
    );

    final columnName = camelCaseFormatter.format(
      source,
    );

    final result = '${tableName}Column$columnName';

    return result;
  }
}
