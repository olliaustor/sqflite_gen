import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates field definition for column
class ColumnToFieldDefinitionGenerator {
  /// Generates field definition for column from given [ColumnDefinition]
  ///  'columnDefinition': column definition
  ///
  /// Returns [String] containing the field definition for column
  String call(ColumnDefinition columnDefinition) {
    final result =
        'final ${columnDefinition.toFieldType()} ${columnDefinition.toFieldName()};';

    return result;
  }
}
