import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

class SourceColumnNameToFieldDefinitionGenerator extends SourceGenerator {
  SourceColumnNameToFieldDefinitionGenerator(this.columnDefinition) {}

  final ColumnDefinition columnDefinition;

  @override
  String generate() {
    final fieldType = 'int';

    final fieldName = UnderscoreToCamelCaseConverter(
      startsWithUpperCase: false,
    ).convert(
      columnDefinition.columnName,
    );

    final result = 'final ${fieldType} ${fieldName};';

    return result;
  }
}
