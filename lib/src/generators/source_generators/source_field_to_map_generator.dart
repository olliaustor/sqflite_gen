import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_to_to_map_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

// https://github.com/tekartik/sqflite/blob/master/sqflite/README.md

class SourceFieldToMapGenerator extends SourceGenerator {
  SourceFieldToMapGenerator(
      this.sqlTableName, List<ColumnDefinition> this.columnDefinitions) {}

  final List<ColumnDefinition> columnDefinitions;
  final String sqlTableName;

  final placeholderAssignments = '%assignments%';
  final placeholderKeyAssignment = '%placeholderKeyAssignment%';
  final placeholderPropertyName = '%placeholderPropertyName%';
  final placeholderColumnConst = '%placeholderColumnConst%';

  final primaryKeyAssignmentContent = '''
  
    if (%placeholderPropertyName% != null) {
      map[%placeholderColumnConst%] = %placeholderPropertyName%;
    }
''';

  final content = '''
  Map<String, Object?> toMap() {
    var map = <String, Object?> {
%assignments%
    };
%placeholderKeyAssignment%        
    return map;
  }  
''';

  @override
  String generate() {
    final sb = StringBuffer();
    final columnToConstConverter = ColumnNameToConstNameConverter(sqlTableName);
    var primaryKeyAssignment = '';

    for (final columnDefinition in columnDefinitions) {
      final assignmentGenerator =
          SourceColumnToToMapAssignmentGenerator(sqlTableName, columnDefinition);
      final columnConstName = columnToConstConverter.convert(
        columnDefinition.columnName,
      );
      final columnPropertyName = columnDefinition.toFieldName();

      if (columnDefinition.isPrimaryKey() &&
          columnDefinition.isAutoIncrement()) {
        primaryKeyAssignment = primaryKeyAssignmentContent
            .replaceAll(placeholderPropertyName, columnPropertyName)
            .replaceAll(placeholderColumnConst, columnConstName)
            .replaceAll(placeholderColumnConst, columnConstName);
        continue;
      }

      final assignment = assignmentGenerator.generate();
      sb.writeln('      $assignment,');
    }

    return content
        .replaceAll(
          placeholderAssignments,
          sb.toString().trimRight(),
        )
        .replaceAll(
          placeholderKeyAssignment,
          primaryKeyAssignment,
        );
  }
}
