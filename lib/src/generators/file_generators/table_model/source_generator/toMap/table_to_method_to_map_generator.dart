import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/toMap/columns_to_map_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_to_to_map_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';

// https://github.com/tekartik/sqflite/blob/master/sqflite/README.md

/// Generates method toMap
class TableToMethodToMapGenerator {
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

  /// Generates method toMap for given [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing the method declaration of toMap
  String call(CreateTableStatement statement) {
    final sb = StringBuffer();
    final columnToConstConverter = ColumnNameToConstNameConverter(statement.tableName);
    var primaryKeyAssignment = '';

    for (final columnDefinition in statement.columns) {
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
    }

    final assignmentGenerator = ColumnsToMapAssignmentGenerator();

    return content
        .replaceAll(
          placeholderAssignments,
          assignmentGenerator(statement),
        )
        .replaceAll(
          placeholderKeyAssignment,
          primaryKeyAssignment,
        );
  }
}
