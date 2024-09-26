import 'package:sqflite_gen/src/extensions/string_extensions.dart';

/// Formats [String] to CamelCaseNotation
class CamelCaseFormatter {
  /// Creates a new string in which the given [String] in [source]
  /// is converted to CamelCase notation.
  /// The flag [startsWithUpperCase] defines whether the first character will be
  /// in uppercase (default) or not.
  /// ```dart
  /// 'formatter'.format('first_name'); // 'FirstName'
  /// 'formatter'.format('first_name', startsWithUpperCase: false); // 'firstName'
  /// ```
  /// Notice that the resulting string will always be in camelcase to be
  /// compliant with dart syntax.
  String format(String source, {bool startsWithUpperCase = true}) {
    final camelCased = source.contains('_')
        ? source.replaceAll('_', ' ').toTitleCase().replaceAll(' ', '')
        : source;

    final firstChar = startsWithUpperCase
        ? camelCased[0].toUpperCase()
        : camelCased[0].toLowerCase();

    final result = camelCased.replaceRange(
      0,
      1,
      firstChar,
    );

    return result;
  }
}
