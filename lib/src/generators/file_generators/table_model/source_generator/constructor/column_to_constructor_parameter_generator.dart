import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates constructor parameter for column
class ColumnToConstructorParameterGenerator {
  /// Generates constructor parameter for column from given [ColumnDefinition]
  ///  'columnDefinition': column definition
  ///
  /// Returns [String] containing the constructor parameter for column
  String call(ColumnDefinition columnDefinition) {
    final requiredText = columnDefinition.isNonNullable ? 'required ' : '';

    final text = '${requiredText}this.${columnDefinition.toFieldName()},';

    return text;
  }
}
