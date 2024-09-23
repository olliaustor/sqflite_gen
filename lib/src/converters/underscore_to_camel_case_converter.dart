import 'package:sqflite_gen/src/converters/converter_base.dart';
import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';

class UnderscoreToCamelCaseConverter extends Converter {
  UnderscoreToCamelCaseConverter({this.startsWithUpperCase = true});

  final bool startsWithUpperCase;

  @override
  String convert(String source) {
    final result = CamelCaseFormatter().format(
      source,
      startsWithUpperCase: startsWithUpperCase,
    );

    return result;
  }
}
