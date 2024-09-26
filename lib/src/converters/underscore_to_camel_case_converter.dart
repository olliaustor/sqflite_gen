import 'package:sqflite_gen/src/converters/converter_base.dart';
import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';

/// Converts given sql table name and column name to const name
class UnderscoreToCamelCaseConverter extends Converter {
  /// Creates new object.
  /// [startsWithUpperCase] defines whether the first character is uppercase
  /// or not. Default value is ´true´
  UnderscoreToCamelCaseConverter({this.startsWithUpperCase = true});

  /// Flag whether the first character is uppercase or not.
  final bool startsWithUpperCase;

  /// Creates a new string in which the given [String] in [source]
  /// converted from underscore to CamelCase notation.
  /// The [startsWithUpperCase] parameter from the constructor defines whether
  /// the first character is uppercase or not.
  /// ```dart
  /// converter = UnderscoreToCamelCaseConverter();
  /// 'converter'.convert('first_name'); // 'CustomerDetails'
  ///
  /// converter = UnderscoreToCamelCaseConverter(startsWithUpperCase: false);
  /// 'converter'.convert('first_name'); // 'customerDetails'
  ///
  /// ```
  /// Notice that the resulting string will always be in camelcase to be
  /// compliant with dart syntax.
  @override
  String convert(String source) {
    final result = CamelCaseFormatter().format(
      source,
      startsWithUpperCase: startsWithUpperCase,
    );

    return result;
  }
}
