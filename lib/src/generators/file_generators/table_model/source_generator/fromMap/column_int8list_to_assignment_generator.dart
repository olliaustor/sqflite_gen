import 'dart:typed_data';

import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/fromMap/column_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/column_to_const_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates map value assignment for [Int8List] value
class ColumnInt8ListToAssignmentGenerator implements ColumnToAssignmentGenerator {
  /// Generates assignment for given [ColumnDefinition]
  ///  columnDefinition': Column definition
  ///
  /// Returns [String] containing the map value assignment for given column
  @override
  String call(CreateTableStatement statement, ColumnDefinition columnDefinition)
  {
    final columnPropertyName = ColumnToConstNameGenerator()
        .call(statement, columnDefinition);
    final assignment = 'map[$columnPropertyName] as Int8List';

    return columnDefinition.isNonNullable
        ? assignment
        : '$assignment?';
  }
}
