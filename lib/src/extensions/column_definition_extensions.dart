import 'dart:typed_data';

import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// [ColumnDefinition] extensions
extension ColumnDefinitionX on ColumnDefinition {
  /// Converts columnName to dart field name
  String toFieldName() => UnderscoreToCamelCaseConverter(
        startsWithUpperCase: false,
      ).convert(
        columnName,
      );

  /// Converts typeName to dart specific type
  String toFieldType() {
    final uppercaseTypeName = typeName!.toUpperCase();
    final fieldType = typeMappings.firstWhere(
      (entry) => uppercaseTypeName.containsAny(
        entry.value,
      ),
    );

    return fieldType.key + (isNonNullable ? '' : '?');
  }

  /// Returns 'true' when column is defined as primary key, false otherwise
  bool isPrimaryKey() => constraints.any((c) => c
      is PrimaryKeyColumn
      //.toString()
      //.toUpperCase()
      //.contains('PRIMARY KEY'),
  );

  /// Returns 'true' when column is defined as auto increment, false otherwise
  bool isAutoIncrement() => constraints.any((c) => c
      is PrimaryKeyColumn && c.autoIncrement
      //.toString()
      //.toUpperCase()
      //.contains('AUTOINCREMENT'),
  );
}

/// Type mapping from different database types to dart types
const List<MapEntry<String, List<String>>> typeMappings = [
  MapEntry('int', typeNamesInt),
  MapEntry('String', typeNamesString),
  MapEntry('Uint8List', typeNamesUint8List),
  MapEntry('bool', typeNamesBool),
  MapEntry('DateTime', typeNamesDateTime),
  MapEntry('Double', typeNamesDouble),
];

// These values are from here: https://www.sqlite.org/datatype3.html

/// Allowed database types to be mapped to dart [int]
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

/// Allowed database types to be mapped to dart [String]
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

/// Allowed database types to be mapped to dart [Uint8List]
const List<String> typeNamesUint8List = [
  'BLOB',
];

/// Allowed database types to be mapped to dart [bool]
const List<String> typeNamesBool = [
  'BOOL',
];

/// Allowed database types to be mapped to dart [DateTime]
const List<String> typeNamesDateTime = ['DATE', 'DATETIME'];

/// Allowed database types to be mapped to dart [double]
const List<String> typeNamesDouble = [
  'REAL',
  'DOUBLE',
  'DOUBLE PRECISION',
  'FLOAT',
  'NUMERIC',
  'DECIMAL',
];
