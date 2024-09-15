import 'package:sqlparser/sqlparser.dart';

/// Generates map value assignment for value
mixin ColumnToAssignmentGenerator {
  /// Generates assignment for given [ColumnDefinition]
  ///  columnDefinition': Column definition
  ///
  /// Returns [String] containing the map value assignment for given column
  String call(ColumnDefinition columnDefinition);
}
