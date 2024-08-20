import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';

class SourceColumnNameToConstDefinitionGenerator extends SourceGenerator {
  SourceColumnNameToConstDefinitionGenerator(this.sqlTableName, this.sqlColumnName) {}

  final String sqlTableName;
  final String sqlColumnName;

  @override
  String generate() {
    final columnConstName =
      ColumnNameToConstNameConverter(sqlTableName).convert(sqlColumnName);

    final result = 'const String ${columnConstName} = \'${sqlColumnName}\';';

    return result;
  }
}
