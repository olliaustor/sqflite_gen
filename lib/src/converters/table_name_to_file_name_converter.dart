import 'package:sqflite_gen/src/converters/camel_case_to_underscore_converter.dart';
import 'package:sqflite_gen/src/converters/converter_base.dart';

class TableNameToFileNameConverter extends Converter {
  final converter = CamelCaseToUnderscoreConverter();

  @override
  String convert(String source) {
    final result = converter.convert(source);

    return result;
  }
}
