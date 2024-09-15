import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/columns_autoincrement_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/columns_to_map_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';

// https://github.com/tekartik/sqflite/blob/master/sqflite/README.md

/// Generates method toMap
class TableToMethodToMapGenerator {
  /// Placeholder for column value to map assignments
  final placeholderAssignments = '%assignments%';
  /// Placeholder for special assignment when table includes an auto increment
  /// column
  final placeholderKeyAssignment = '%placeholderAutoIncrementAssignment%';

  /// Method content with placeholder
  final content = '''
  Map<String, Object?> toMap() {
    var map = <String, Object?> {
%assignments%
    };
%placeholderAutoIncrementAssignment%        
    return map;
  }  
''';

  /// Generates method toMap for given [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing the method declaration of toMap
  String call(CreateTableStatement statement) {
    final assignmentGenerator = ColumnsToMapAssignmentGenerator();
    final autoIncrementGenerator = ColumnsAutoIncrementAssignmentGenerator();

    return content
        .replaceAll(
          placeholderAssignments,
          assignmentGenerator(statement),
        )
        .replaceAll(
          placeholderKeyAssignment,
      autoIncrementGenerator(statement),
        );
  }
}
