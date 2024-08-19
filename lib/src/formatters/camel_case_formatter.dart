import 'package:sqflite_gen/src/extensions/string_extensions.dart';

class CamelCaseFomatter {
  String format(String source, {bool startsWithUpperCase = true}) {
    final camelCased =
        source.replaceAll('_', ' ').toTitleCase().replaceAll(' ', '');

    final result = startsWithUpperCase
        ? camelCased
        : camelCased.replaceRange(
            0,
            1,
            camelCased[0].toLowerCase(),
          );

    return result;
  }
}
