import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates value assignment
class ColumnToAssignmentGenerator {
  /// Generates value assignment for given [ColumnDefinition]
  ///  columnDefinition': Column definition
  ///
  /// Returns [String] containing the value assignment for given column
  String call(ColumnDefinition columnDefinition) {
    final fieldName = columnDefinition.toFieldName();
    return '      $fieldName: ${_getAssignment(columnDefinition)}';
  }

  String _getAssignment(ColumnDefinition columnDefinition) {
    final fieldName = columnDefinition.toFieldName();
    if (columnDefinition.isNonNullable) {
      return 'isNull($fieldName) ? this.$fieldName : $fieldName!';
    }

    return 'isNull($fieldName) ? this.$fieldName : ($fieldName!.value)';
  }
}
