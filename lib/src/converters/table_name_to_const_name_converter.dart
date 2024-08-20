import 'package:sqflite_gen/src/converters/converter_base.dart';
import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';

class TableNameToConstNameConverter extends Converter {
  final CamelCaseFormatter camelCaseFormatter = CamelCaseFormatter();

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
