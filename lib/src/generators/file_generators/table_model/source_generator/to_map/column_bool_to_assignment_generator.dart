import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates map value assignment for [bool] value
class ColumnBoolToAssignmentGenerator implements ColumnToAssignmentGenerator {
  /// Generates assignment for given [ColumnDefinition]
  ///  columnDefinition': Column definition
  ///
  /// Returns [String] containing the map value assignment for given column
  @override
  String call(ColumnDefinition columnDefinition) {
    final columnPropertyName = columnDefinition.toFieldName();

    return columnDefinition.isNonNullable
        ? _propertyToAssignment(columnPropertyName)
        : _propertyToNullableAssignment(columnPropertyName, columnDefinition);
  }

  String _propertyToAssignment(String propertyName) {
    return 'boolToInt($propertyName)';
  }

  String _propertyToNullableAssignment(
    String propertyName,
    ColumnDefinition columnDefinition,
  ) {
    return 'isNull($propertyName) ? null : '
        '${_propertyToAssignment('$propertyName!')}';
  }
}
