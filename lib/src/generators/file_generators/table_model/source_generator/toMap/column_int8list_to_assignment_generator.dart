import 'dart:typed_data';

import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/toMap/column_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates map value assignment for [Int8List] value
class ColumnInt8ListToAssignmentGenerator implements ColumnToAssignmentGenerator {
  /// Generates assignment for given [ColumnDefinition]
  ///  columnDefinition': Column definition
  ///
  /// Returns [String] containing the map value assignment for given column
  @override
  String call(ColumnDefinition columnDefinition)
  {
    return columnDefinition.toFieldName();
  }
}
