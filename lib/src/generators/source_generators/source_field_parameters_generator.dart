import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

class SourceFieldParametersGenerator extends SourceGenerator {
  SourceFieldParametersGenerator(
      List<ColumnDefinition> this.columnDefinitions) {}

  final List<ColumnDefinition> columnDefinitions;

  @override
  String generate() {
    final sb = StringBuffer();

    for (final columnDefinition in columnDefinitions) {
      final requiredText = columnDefinition.isNonNullable
        ? 'required '
        : '';

      final text = '${requiredText}this.${columnDefinition.toFieldName()},';
      sb.writeln('    $text');
    }

    return sb.toString().trimRight();
  }
}
