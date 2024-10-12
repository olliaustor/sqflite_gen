import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_bool_to_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_datetime_to_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_double_to_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_int8list_to_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_int_to_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_string_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates map assignment for given column
class ColumnToMapAssignmentGenerator {
  /// Type mapping from different database types to dart types
  final List<MapEntry<String, ColumnToAssignmentGenerator>> typeMappings = [
    MapEntry('int', ColumnIntToAssignmentGenerator()),
    MapEntry('String', ColumnStringToAssignmentGenerator()),
    MapEntry('Uint8List', ColumnInt8ListToAssignmentGenerator()),
    MapEntry('bool', ColumnBoolToAssignmentGenerator()),
    MapEntry('DateTime', ColumnDateTimeToAssignmentGenerator()),
    MapEntry('double', ColumnDoubleToAssignmentGenerator()),
  ];

  /// Generates map assignment for given [CreateTableStatement] and
  /// [ColumnDefinition]
  ///  'statement': create table statement
  ///  'columnDefinition': column definition
  ///
  /// Returns [String] containing the map assignment
  String call(
    CreateTableStatement statement,
    ColumnDefinition columnDefinition,
  ) {
    final columnToConstConverter =
        ColumnNameToConstNameConverter(statement.tableName);

    final columnConstName = columnToConstConverter.convert(
      columnDefinition.toFieldName(),
    );
    final columnFieldType = columnDefinition.toFieldType().replaceAll('?', '');

    final generator =
        typeMappings.firstWhere((entry) => entry.key == columnFieldType).value;

    final sourceValue = generator(columnDefinition);

    final result = '      $columnConstName: $sourceValue';
    return result;
  }
}
