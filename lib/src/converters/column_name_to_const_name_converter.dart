import 'package:sqflite_gen/src/converters/converter_base.dart';
import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';

class ColumnNameToConstNameConverter extends Converter {
  ColumnNameToConstNameConverter(this.sqlTableName);

  final CamelCaseFormatter camelCaseFormatter = CamelCaseFormatter();

  final String sqlTableName;

  @override
  String convert(String source) {
    final tableName = camelCaseFormatter.format(
      sqlTableName,
      startsWithUpperCase: false,
    );

    final columnName = camelCaseFormatter.format(
      source,
    );

    final result = '${tableName}Column$columnName';

    return result;
  }
}
