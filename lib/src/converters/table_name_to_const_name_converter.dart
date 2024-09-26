import 'package:sqflite_gen/src/converters/converter_base.dart';
import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';

/// Converts given sql table name to const name
class TableNameToConstNameConverter extends Converter {
  /// Formatter to ensure CamelCase notation
  final CamelCaseFormatter camelCaseFormatter = CamelCaseFormatter();

  /// Creates a new string in which the given [String] in [source]
  /// is converted to reflect a const name which can be
  /// used in generated code.
  /// ```dart
  /// 'converter'.convert('customer_Details'); // 'customerDetailsTable'
  /// ```
  /// Notice that the resulting string will always be in camelcase to be
  /// compliant with dart syntax.
  @override
  String convert(String source) {
    final tableName = camelCaseFormatter.format(
      source,
      startsWithUpperCase: false,
    );

    final result = '${tableName}Table';

    return result;
  }
}
