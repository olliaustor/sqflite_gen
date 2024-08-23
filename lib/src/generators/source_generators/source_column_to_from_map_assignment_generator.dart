import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

class SourceColumnToFromMapAssignmentGenerator extends SourceGenerator {
  SourceColumnToFromMapAssignmentGenerator(
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
      case 'String':
        sourceValue = _propertyToStringAssigment(columnConstName);
      case 'String?':
        sourceValue = _propertyToNullableStringAssigment(columnConstName);
      case 'int':
        sourceValue = _propertyToIntAssigment(columnConstName);
      case 'int?':
        sourceValue = _propertyToNullableIntAssigment(columnConstName);
      case 'bool':
        sourceValue = _propertyToBoolAssigment(columnConstName);
      case 'bool?':
        sourceValue = _propertyToNullableBoolAssigment(columnConstName);
      case 'DateTime':
        sourceValue = _propertyToDateTimeAssigment(columnConstName);
      case 'DateTime?':
        sourceValue = _propertyToNullableDateTimeAssigment(columnConstName);
      default:
        sourceValue = '$columnPropertyName = map[$columnConstName]';
    }

    return sourceValue;
  }

  String _propertyToStringAssigment(String propertyName) {
    return 'map[$propertyName] as String';
  }

  String _propertyToNullableStringAssigment(String propertyName) {
    return '${_propertyToStringAssigment(propertyName)}?';
  }

  String _propertyToIntAssigment(String propertyName) {
    return 'map[$propertyName] as int';
  }

  String _propertyToNullableIntAssigment(String propertyName) {
    return '${_propertyToIntAssigment(propertyName)}?';
  }

  String _propertyToBoolAssigment(String propertyName) {
    return 'map[$propertyName] == 1';
  }

  String _propertyToNullableBoolAssigment(String propertyName) {
    return 'map[$propertyName] == null ? null : (${_propertyToBoolAssigment(propertyName)})';
  }

  String _propertyToDateTimeAssigment(String propertyName) {
    return 'DateTime.fromMillisecondsSinceEpoch(map[$propertyName]! as int, isUtc: true,)';
  }

  String _propertyToNullableDateTimeAssigment(String propertyName) {
    return 'map[$propertyName] == null ? null : (${_propertyToDateTimeAssigment(propertyName)})';
  }
}
