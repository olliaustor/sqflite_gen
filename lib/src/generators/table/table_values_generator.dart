import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite_gen/src/converters/camel_case_to_underscore_converter.dart';
import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_const_names_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_creates_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_table_name_to_const_definition_generator.dart';

import 'package:sqlparser/sqlparser.dart';

class TableValuesGenerator extends FileGenerator {
  TableValuesGenerator(this.statement);

  final Either<CreateTableStatement, String> statement;

  final String placeholderUnderscoreSqlTableName = '%underscoreSqlTableName%';
  final String placeholderLowerCaseWithUnderscoreSqlTableName =
      '%lowerCaseWithUnderscoreSqlTableName%';
  final String placeholderLowerCaseSqlTableName = '%lowerCaseSqlTableName%';
  final String placeholderConstTable = '%const_definition_table%';
  final String placeholderConstColumns = '%const_definition_columns%';
  final String placeholderColumnDefinitions = '%column_definitions%';

  final String targetFileName =
      'tables/%underscoreSqlTableName%/%underscoreSqlTableName%_values.dart';

  final String createStatement = '''
%const_definition_table%
%const_definition_columns%

const String %lowerCaseSqlTableName%Create = \'\'\'
CREATE TABLE \$%lowerCaseSqlTableName% (
%column_definitions%
)
\'\'\';
  ''';

  @override
  Future<FileGeneratorResult> generate() async {
    final createTableStatement = statement.asLeft();
    final sqlTableName = createTableStatement.tableName;

    final mapReplacements = [
      MapEntry(
        placeholderLowerCaseWithUnderscoreSqlTableName,
        CamelCaseToUnderscoreConverter().convert(sqlTableName),
      ),
      MapEntry(
        placeholderLowerCaseSqlTableName,
        TableNameToConstNameConverter()
            .convert(sqlTableName)
            .toStartWithLowerCase(),
      ),
      MapEntry(
        placeholderConstTable,
        SourceTableNameToConstDefinitionGenerator(sqlTableName).generate(),
      ),
      MapEntry(
        placeholderConstColumns,
        _getConstColumnsReplacementValue(
          createTableStatement.tableName,
          createTableStatement.columns,
        ),
      ),
      MapEntry(
        placeholderColumnDefinitions,
        _getColumnsDefinitionReplacementValue(
          createTableStatement.tableName,
          createTableStatement.columns,
        ),
      ),
      MapEntry(placeholderUnderscoreSqlTableName,
          CamelCaseToUnderscoreConverter().convert(sqlTableName)),
    ];

    final content = _replaceAll(
      createStatement,
      mapReplacements,
    );

    final fullFileName = _getFullFileName(mapReplacements);

    return FileGeneratorResult(
      targetFileName: fullFileName,
      content: content,
    );
  }

  String _getConstColumnsReplacementValue(
      String tableName, List<ColumnDefinition> columnDefinitions) {
    var generator = SourceColumnConstNamesGenerator(
      tableName,
      columnDefinitions,
    );

    return generator.generate();
  }

  String _getColumnsDefinitionReplacementValue(
      String tableName, List<ColumnDefinition> columnDefinitions) {
    var generator = SourceColumnCreatesGenerator(
      tableName,
      columnDefinitions,
    );

    return generator.generate();
  }

  String _getFullFileName(List<MapEntry<String, String>> mapReplaceValues) {
    final fullFileName = _replaceAll(targetFileName, mapReplaceValues);

    return fullFileName;
  }

  String _replaceAll(
    String source,
    List<MapEntry<String, String>> mapReplaceValues,
  ) {
    var text = source;

    for (final mapEntry in mapReplaceValues) {
      final key = mapEntry.key;
      final value = mapEntry.value;

      text = text.replaceAll(key, value);
    }

    return text;
  }
}
