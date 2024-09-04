import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/fields/column_to_field_definition_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates field definitions for given columns
class ColumnsToFieldDefinitionsGenerator {
  /// Generates field definitions for columns from given
  /// [List<ColumnDefinition>]
  ///  'columnDefinitions': list of column definitions
  ///
  /// Returns [String] containing the field definitions for all columns
  String call(List<ColumnDefinition> columnDefinitions) {
    final sb = StringBuffer();
    final generator = ColumnToFieldDefinitionGenerator();

    for (final columnDefinition in columnDefinitions) {
      sb.writeln('    ${generator(columnDefinition)}');
    }

    return sb.toString().trimRight();
  }
}
