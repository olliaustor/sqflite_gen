import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/toMap/column_to_map_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates map assignment for given columns
class ColumnsToMapAssignmentGenerator {
  /// Generates map assignments for all columns in given [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing a list of map assignments
  String call(CreateTableStatement statement) {
    final generator = ColumnToMapAssignmentGenerator();

    final sB = StringBuffer();

    for (final column in statement.columns) {
      sB.writeln('${generator(statement, column)},');
    }

    return sB.toString().trimRight();
  }
}
