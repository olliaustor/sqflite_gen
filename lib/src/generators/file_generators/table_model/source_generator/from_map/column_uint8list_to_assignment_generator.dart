import 'dart:typed_data';

import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/from_map/column_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/column_to_const_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates map value assignment for [Uint8List] value
class ColumnUint8ListToAssignmentGenerator
    implements ColumnToAssignmentGenerator {
  /// Generates assignment for given [ColumnDefinition]
  ///  columnDefinition': Column definition
  ///
  /// Returns [String] containing the map value assignment for given column
  @override
  String call(
    CreateTableStatement statement,
    ColumnDefinition columnDefinition,
  ) {
    final columnPropertyName =
        ColumnToConstNameGenerator().call(statement, columnDefinition);
    final assignment = 'map[$columnPropertyName] as Uint8List';

    return columnDefinition.isNonNullable ? assignment : '$assignment?';
  }
}
