import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/copy_with/column_to_parameter_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates method parameters
class ColumnsToParameterGenerator {
  /// Generates map parameters for all columns in given [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing a list of parameters
  String call(CreateTableStatement statement) {
    final generator = ColumnToParameterGenerator();

    final sB = StringBuffer();

    for (final column in statement.columns) {
      sB.writeln('${generator(column)},');
    }

    return sB.toString().trimRight();
  }
}
