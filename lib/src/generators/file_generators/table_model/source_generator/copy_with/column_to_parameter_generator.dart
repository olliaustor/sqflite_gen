import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates method parameter
class ColumnToParameterGenerator {
  /// Generates method parameter for given [ColumnDefinition]
  ///  columnDefinition': Column definition
  ///
  /// Returns [String] containing the method parameter for given column
  String call(ColumnDefinition columnDefinition) {
    final fieldName = columnDefinition.toFieldName();

    var fieldType = columnDefinition.toFieldType();
    if (!columnDefinition.isNonNullable) {
      fieldType = 'Wrapped<$fieldType>?';
    }
    if (!fieldType.endsWith('?')) fieldType += '?';


    return '    $fieldType $fieldName';
  }
}
