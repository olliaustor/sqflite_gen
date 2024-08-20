import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';

class SourceTableNameToConstDefinitionGenerator extends SourceGenerator {
  SourceTableNameToConstDefinitionGenerator(this.tableName);

  final String tableName;

  @override
  String generate() {
    final columnTableName =
      TableNameToConstNameConverter().convert(tableName);

    final result = 'const String ${columnTableName} = \'${tableName}\';';

    return result;
  }
}
