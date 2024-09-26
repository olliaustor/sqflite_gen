import 'package:sqflite_gen/src/converters/converter_base.dart';

/// Converts text from camel case notation to underscore
/// ThisIsATestText -> this_is_a_test_text
class CamelCaseToUnderscoreConverter extends Converter {
  /// Creates new object
  CamelCaseToUnderscoreConverter() {
    final list = List.generate(
      26,
      (index) => String.fromCharCode(index + 65),
    );

    _charMapList =
        list.map((item) => MapEntry(item, '_${item.toLowerCase()}')).toList();
  }

  late List<MapEntry<String, String>> _charMapList;

  /// Creates a new string in which the given [String] in [source]
  /// is converted from CamelCase notation to underscore.
  /// ```dart
  /// 'converter'.convert('ThisIsATestText'); // 'this_is_a_test_text'
  /// ```
  /// Notice that string without camelcase (uppercase characters) will be
  /// unchanged.
  @override
  String convert(String source) {
    var result = source;
    for (final charMap in _charMapList) {
      result = result.replaceAll(charMap.key, charMap.value);
    }

    result = result.replaceAll('__', '_');

    while (result[0] == '_') {
      result = result.substring(1, result.length);
    }

    return result;
  }
}
