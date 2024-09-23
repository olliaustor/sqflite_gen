import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/copy_with/columns_to_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/copy_with/columns_to_parameter_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates method copyWith
class TableToMethodCopyWithGenerator {
  /// Placeholder for value assignments
  final placeholderAssignments = '%assignments%';

  /// Placeholder for method parameters
  final placeholderParameters = '%parameters%';

  /// Placeholder for class name
  final placeholderTableName = '%tableName%';

  final parametersContent = '''
{
%parameters%
  }''';

  /// Method content with placeholder
  final content = '''
  %tableName% copyWith(%parameters%) {
    return %tableName%(
%assignments%
    );
  }
''';

  /// Generates method copyWith for given [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing the method declaration of copyWith
  String call(CreateTableStatement statement) {
    final sqlTableName = statement.toClassName();
    final assignmentsGenerator = ColumnsToAssignmentGenerator();
    final parametersGenerator = ColumnsToParameterGenerator();
    final tableName = UnderscoreToCamelCaseConverter().convert(sqlTableName);
    final assignments = assignmentsGenerator(statement);
    final parameters = parametersGenerator(statement);

    final parametersList = statement.columns.isEmpty
        ? ''
        : parametersContent.replaceAll(placeholderParameters, parameters);

    return content
        .replaceAll(placeholderAssignments, assignments)
        .replaceAll(placeholderTableName, tableName)
        .replaceAll(placeholderParameters, parametersList);
  }
}
