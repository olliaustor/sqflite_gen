import 'package:sqflite_gen/src/extensions/string_extensions.dart';

class CamelCaseFormatter {
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
