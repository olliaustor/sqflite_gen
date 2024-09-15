import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/fromMap/columns_to_from_map_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/fromMap/columns_to_from_map_constructor_generator.dart';
import 'package:sqlparser/sqlparser.dart';

// https://github.com/tekartik/sqflite/blob/master/sqflite/README.md

/// Generates method fromMap
class TableToMethodFromMapGenerator {
  /// Placeholder for value assignments
  final placeholderAssignments = '%assignments%';

  /// Placeholder for constructor call
  final placeholderConstructorCall = '%constructorCall%';

  /// Placeholder for class name
  final placeholderTableName = '%tableName%';

  /// Method content with placeholder
  final content = '''
  factory %tableName%.fromMap(Map<String, Object?> map) {
%assignments%

%constructorCall%
  }  
''';

  /// Generates method fromMap for given [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing the method declaration of fromMap
  String call(CreateTableStatement statement) {
    final sqlTableName = statement.toClassName();
    final assignmentsGenerator = ColumnsToFromMapAssignmentGenerator();
    final constructorGenerator = ColumnsToFromMapConstructorGenerator();
    final tableName = UnderscoreToCamelCaseConverter().convert(sqlTableName);
    final assignments = assignmentsGenerator(statement);
    final constructor = constructorGenerator(statement);

    return content
        .replaceAll(placeholderAssignments, assignments)
        .replaceAll(placeholderTableName, tableName)
        .replaceAll(placeholderConstructorCall, constructor);
  }
}
