import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/converters/converter_base.dart';

class ColumnNameToConstDefinitionConverter extends Converter {
  ColumnNameToConstDefinitionConverter(this.sqlTableName) {}

  final String sqlTableName;

  @override
  String convert(String source) {
    final columnConstName =
      ColumnNameToConstNameConverter(sqlTableName).convert(source);

    final result = 'const String ${columnConstName} = \'${source}\';';

    return result;
  }
}
