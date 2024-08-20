import 'package:sqflite_gen/src/converters/column_name_to_const_definition_converter.dart';
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
    final converter = ColumnNameToConstDefinitionConverter(tableName);
    for (final columnDefinition in columnDefinitions) {
      sb.writeln(converter.convert(columnDefinition.columnName));
    }

    return sb.toString().trimRight();
  }
}
