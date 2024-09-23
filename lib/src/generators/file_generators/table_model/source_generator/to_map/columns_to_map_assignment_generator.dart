import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_to_map_assignment_generator.dart';
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
    final validColumns =
        statement.columns.where((column) => !column.isAutoIncrement());

    for (final column in validColumns) {
      sB.writeln('${generator(statement, column)},');
    }

    return sB.toString().trimRight();
  }
}
