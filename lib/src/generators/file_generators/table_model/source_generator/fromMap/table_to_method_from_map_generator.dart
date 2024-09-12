import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/fromMap/columns_to_from_map_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';

// https://github.com/tekartik/sqflite/blob/master/sqflite/README.md

class TableToMethodFromMapGenerator {
  final placeholderAssignments = '%assignments%';
  final placeholderConstructorCall = '%constructorCall%';
  final placeholderTableName = '%tableName%';
  final placeholderParameters = '%parameters%';

  final constructor = '''    return %tableName%(
%parameters%
    );''';

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
    final tableName = UnderscoreToCamelCaseConverter().convert(sqlTableName);
    final assignments = assignmentsGenerator(statement);

    return content
        .replaceAll(placeholderAssignments, assignments)
        .replaceAll(placeholderTableName, tableName)
        .replaceAll(placeholderConstructorCall, _getConstructor(statement));
  }

  String _getConstructor(CreateTableStatement statement) {
    final sb = StringBuffer();
    for (final columnDefinition in statement.columns) {
      final fieldName = columnDefinition.toFieldName();
      sb.writeln('      $fieldName: $fieldName, ');
    }

    return constructor
        .replaceAll(placeholderTableName, statement.toClassName())
        .replaceAll(placeholderParameters, sb.toString().trimRight());
  }
}
