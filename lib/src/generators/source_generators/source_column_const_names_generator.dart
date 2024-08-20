import 'package:sqflite_gen/src/generators/source_generators/source_column_name_to_const_definition_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

class SourceColumnConstNamesGenerator extends SourceGenerator {
  SourceColumnConstNamesGenerator(
      String this.tableName, List<ColumnDefinition> this.columnDefinitions) {}

  final String tableName;
  final List<ColumnDefinition> columnDefinitions;

  @override
  String generate() {
    final sb = StringBuffer();

    for (final columnDefinition in columnDefinitions) {
      final generator = SourceColumnNameToConstDefinitionGenerator(
        tableName,
        columnDefinition.columnName,
      );
      sb.writeln(generator.generate());
    }

    return sb.toString().trimRight();
  }
}
