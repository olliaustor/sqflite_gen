import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/copy_with/column_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates assignment parameters
class ColumnsToAssignmentGenerator {
  /// Generates assignments for all columns in given [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing a list of assignments
  String call(CreateTableStatement statement) {
    final generator = ColumnToAssignmentGenerator();

    final sB = StringBuffer();

    for (final column in statement.columns) {
      sB.writeln('${generator(column)},');
    }

    return sB.toString().trimRight();
  }
}
