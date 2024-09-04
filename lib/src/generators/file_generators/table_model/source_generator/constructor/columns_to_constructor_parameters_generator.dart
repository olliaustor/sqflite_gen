import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/constructor/column_to_constructor_parameter_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates constructor parameters for given columns
class ColumnsToConstructorParametersGenerator {
  /// Generates constructor parameters for columns from given
  /// [List<ColumnDefinition>]
  ///  'columnDefinitions': list of column definitions
  ///
  /// Returns [String] containing the constructor parameters for all column
  String call(List<ColumnDefinition> columnDefinitions) {
    final sb = StringBuffer();
    final generator = ColumnToConstructorParameterGenerator();

    for (final columnDefinition in columnDefinitions) {
      sb.writeln('    ${generator(columnDefinition)}');
    }

    return sb.toString().trimRight();
  }
}
