import 'package:sqflite_gen/src/converters/converter_base.dart';

class CamelCaseToUnderscoreConverter extends Converter {
  CamelCaseToUnderscoreConverter() {
    final list = List.generate(
      26,
          (index) => String.fromCharCode(index + 65),
    );

    _charMapList =
        list.map((item) => MapEntry(item, '_${item.toLowerCase()}')).toList();
  }

  late List<MapEntry<String, String>> _charMapList;

  @override
  String convert(String source) {
    var result = source;
    for (final charMap in _charMapList)
    {
      result = result.replaceAll(charMap.key, charMap.value);
    }

    result = result.replaceAll('__', '_');

    while (result[0] == '_') {
      result = result.substring(1, result.length);
    }

    return result;
  }
}
