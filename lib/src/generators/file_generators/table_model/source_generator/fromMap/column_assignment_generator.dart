import 'package:sqlparser/sqlparser.dart';

/// Generates variable assignment from map value
mixin ColumnToAssignmentGenerator {
  /// Generates assignment for given [CreateTableStatement] and
  /// [ColumnDefinition]
  ///  'statement': Table definition
  ///  'columnDefinition': Column definition
  ///
  /// Returns [String] containing the map value assignment for given column
  String call(
    CreateTableStatement statement,
    ColumnDefinition columnDefinition,
  );
}
