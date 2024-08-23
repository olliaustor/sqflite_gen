import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_to_from_map_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_to_to_map_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

// https://github.com/tekartik/sqflite/blob/master/sqflite/README.md

class SourceFieldFromMapGenerator extends SourceGenerator {
  SourceFieldFromMapGenerator(
      this.sqlTableName, List<ColumnDefinition> this.columnDefinitions) {}

  final List<ColumnDefinition> columnDefinitions;
  final String sqlTableName;

  final placeholderAssignments = '%assignments%';
  final placeholderConstructorCall = '%constructorCall%';
  final placeholderTableName = '%tableName%';
  final placeholderParameters = '%parameters%';

  final constructor = '''    return %tableName%(
%parameters%
    );''';

  final content = '''  
  factory %tableName%.fromMap(Map<String, Object?> map) {
%assignments%

%constructorCall%
  }  
''';

  @override
  String generate() {
    final sb = StringBuffer();
    final columnToConstConverter = ColumnNameToConstNameConverter(sqlTableName);
    final tableName = UnderscoreToCamelCaseConverter().convert(sqlTableName);
    final assignments = _getAssignments(columnToConstConverter);
    final constructor = _getConstructor(tableName);

    return content
        .replaceAll(
          placeholderAssignments,
      assignments,
        )
        .replaceAll(
          placeholderTableName,
          tableName,
        )
        .replaceAll(
      placeholderConstructorCall,
      _getConstructor(tableName),
    );
  }

  String _getAssignments(ColumnNameToConstNameConverter columnToConstConverter) {
    final sb = StringBuffer();
    for (final columnDefinition in columnDefinitions) {
      final columnConstName = columnToConstConverter.convert(
        columnDefinition.columnName,
      );
      final columnPropertyName = columnDefinition.toFieldName();
      final assignment = SourceColumnToFromMapAssignmentGenerator(
        sqlTableName,
        columnDefinition,
      ).generate();

      sb.writeln('    final $columnPropertyName = $assignment;');
    }

    return sb.toString().trimRight();
  }

  String _getConstructor(String tableName) {
    final sb = StringBuffer();
    for (final columnDefinition in columnDefinitions) {
      final fieldName = columnDefinition.toFieldName();
      sb.writeln('      $fieldName: $fieldName, ');
    }

    return constructor
        .replaceAll(placeholderTableName, tableName)
        .replaceAll(placeholderParameters, sb.toString().trimRight());
  }
}
