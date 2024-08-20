import 'package:sqflite_gen/src/converters/converter_base.dart';
import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';

class TableNameToConstDefinitionConverter extends Converter {
  @override
  String convert(String source) {
    final columnTableName =
      TableNameToConstNameConverter().convert(source);

    final result = 'const String ${columnTableName} = \'${source}\';';

    return result;
  }
}
