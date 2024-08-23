import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

class SourceFieldDefinitionsGenerator extends SourceGenerator {
  SourceFieldDefinitionsGenerator(
      List<ColumnDefinition> this.columnDefinitions) {}

  final List<ColumnDefinition> columnDefinitions;

  @override
  String generate() {
    final sb = StringBuffer();

    for (final columnDefinition in columnDefinitions) {
      sb.writeln('  final ${columnDefinition.toFieldType()} ${columnDefinition.toFieldName()};');
    }

    return sb.toString().trimRight();
  }
}
