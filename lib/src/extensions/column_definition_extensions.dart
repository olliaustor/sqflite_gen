import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

// These values are from here: https://www.sqlite.org/datatype3.html

const List<String> typeNamesInt = [
  'INT',
  'INTEGER',
  'TINYINT',
  'SMALLINT',
  'MEDIUMINT',
  'BIGINT',
  'UNSIGNED BIG INT',
  'INT2',
  'INT8',
];

const List<String> typeNamesString = [
  'CHARACTER',
  'VARCHAR',
  'VARYING CHARACTER',
  'NCHAR',
  'NATIVE CHARACTER',
  'NVARCHAR',
  'TEXT',
  'CLOB',
  'STRING'
];

const List<String> typeNamesUint8List = [
  'BLOB',
];

const List<String> typeNamesBool = [
  'BOOL',
];

const List<String> typeNamesDateTime = ['DATE', 'DATETIME'];

const List<String> typeNamesDouble = [
  'REAL',
  'DOUBLE',
  'DOUBLE PRECISION',
  'FLOAT',
  'NUMERIC',
  'DECIMAL',
];

const List<MapEntry<String, List<String>>> typeMappings = [
  MapEntry('int', typeNamesInt),
  MapEntry('String', typeNamesString),
  MapEntry('Uint8List', typeNamesUint8List),
  MapEntry('bool', typeNamesBool),
  MapEntry('DateTime', typeNamesDateTime),
  MapEntry('Double', typeNamesDouble),
];

extension ColumnDefinitionX on ColumnDefinition {
  String toFieldName() => UnderscoreToCamelCaseConverter(
        startsWithUpperCase: false,
      ).convert(
        columnName,
      );

  String toFieldType() {
    final uppercaseTypeName = typeName!.toUpperCase();
    final fieldType = typeMappings.firstWhere(
      (entry) => uppercaseTypeName.containsAny(
        entry.value,
      ),
    );

    return fieldType.key + (isNonNullable ? '' : '?');
  }

  bool isPrimaryKey() => constraints.any((c) => c.toString().toUpperCase().contains('PRIMARY KEY'));
  bool isAutoIncrement() => constraints.any((c) => c.toString().toUpperCase().contains('AUTOINCREMENT'));
}
