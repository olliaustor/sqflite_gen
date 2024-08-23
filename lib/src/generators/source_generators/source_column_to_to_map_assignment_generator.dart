import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

class SourceColumnToToMapAssignmentGenerator extends SourceGenerator {
  SourceColumnToToMapAssignmentGenerator(
    this.sqlTableName,
    this.columnDefinition,
  ) {}

  final String sqlTableName;
  final ColumnDefinition columnDefinition;

  final placeholderSourceValue = '%sourceValue%';

  @override
  String generate() {
    final columnToConstConverter = ColumnNameToConstNameConverter(sqlTableName);

    final columnConstName = columnToConstConverter.convert(
      columnDefinition.columnName,
    );
    final columnPropertyName = columnDefinition.toFieldName();

    var sourceValue = columnPropertyName;
    switch (columnDefinition.toFieldType()) {
      case 'bool':
        sourceValue = _propertyToBoolAssigment(columnPropertyName);
      case 'bool?':
        sourceValue = _propertyToNullableBoolAssigment(columnPropertyName);
      case 'DateTime':
        sourceValue = _propertyToDateTimeAssigment(columnPropertyName);
      case 'DateTime?':
        sourceValue = _propertyToNullableDateTimeAssigment(columnPropertyName);
    }

    final result = '$columnConstName: $sourceValue';
    return result;
  }

  String _propertyToBoolAssigment(String propertyName) {
    return '$propertyName ? 1 : 0';
  }

  String _propertyToNullableBoolAssigment(String propertyName) {
    return _nullablePrefix(propertyName).replaceAll(
      placeholderSourceValue,
      '$propertyName! ? 1 : 0',
    );
  }

  String _propertyToDateTimeAssigment(String propertyName) {
    return '$propertyName.toUtc().millisecondsSinceEpoch';
  }

  String _propertyToNullableDateTimeAssigment(String propertyName) {
    return _propertyToDateTimeAssigment('$propertyName?');
  }

  String _nullablePrefix(String propertyName) {
    return columnDefinition.isNonNullable
        ? placeholderSourceValue
        : '$propertyName == null ? null : ($placeholderSourceValue)';
  }
}
