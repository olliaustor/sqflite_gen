import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_const_names_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_creates_generator.dart';
import 'package:sqflite_gen/src/mappers/table_name_mapper.dart';

import 'package:sqlparser/sqlparser.dart';

class TableValuesGenerator extends FileGenerator {
  TableValuesGenerator(this.statement) {}

  final Either<CreateTableStatement, String> statement;

  final String targetDirectory = 'tables/%lowerCaseSqlTableName%';
  final String targetFileName = '%sqlTableName%_values.dart';

  final String placeholderLowerCaseSqlTableName = '%lowerCaseSqlTableName%';
  final String placeholderSqlTableName = '%sqlTableName%';
  final String placeholderConstColumns = '%const_columns%';
  final String placeholderColumnDefinitions = '%column_definitions%';
  final String placeholderConstTableName = '%constTableName%';

  final String createStatement = '''
const String %constTableName% = \'%sqlTableName%\';
%const_columns%

const String %lowerCaseSqlTableName%Create = \'\'\'
CREATE TABLE \$%constTableName% (
%column_definitions%
)
\'\'\';
  ''';

  @override
  Future<FileGeneratorResult> generate() async {
    final CreateTableStatement createTableStatement = statement.asLeft();
    final String sqlTableName = createTableStatement.tableName;

    final mapReplacements = [
      MapEntry(placeholderSqlTableName, sqlTableName),
      _getConstLowerCaseTableNameReplacementValue(sqlTableName),
      _getConstTableNameReplacementValue(sqlTableName),
      _getConstColumnsReplacementValue(
        createTableStatement.tableName,
        createTableStatement.columns,
      ),
      _getColumnsDefinitionReplacementValue(
        createTableStatement.tableName,
        createTableStatement.columns,
      ),
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

  MapEntry<String, String> _getConstLowerCaseTableNameReplacementValue(
      String sqlTableName) {
    return MapEntry(
      placeholderLowerCaseSqlTableName,
      CamelCaseFomatter()
          .format(
            sqlTableName,
            startsWithUpperCase: false,
          )
          .toStartWithLowerCase(),
    );
  }

  MapEntry<String, String> _getConstTableNameReplacementValue(
      String sqlTableName) {
    return MapEntry(
      placeholderConstTableName,
      TableNameMapper(sqlTableName).map().value,
    );
  }

  MapEntry<String, String> _getConstColumnsReplacementValue(
      String tableName, List<ColumnDefinition> columnDefinitions) {
    var generator = SourceColumnConstNamesGenerator(
      tableName,
      columnDefinitions,
    );

    return MapEntry(placeholderConstColumns, generator.generate());
  }

  MapEntry<String, String> _getColumnsDefinitionReplacementValue(
      String tableName, List<ColumnDefinition> columnDefinitions) {
    var generator = SourceColumnCreatesGenerator(
      tableName,
      columnDefinitions,
    );

    return MapEntry(placeholderColumnDefinitions, generator.generate());
  }

  String _getFullFileName(List<MapEntry<String, String>> mapReplaceValues) {
    final filePath = _replaceAll(
      targetDirectory,
      mapReplaceValues,
    );
    final fileName = _replaceAll(
      targetFileName,
      mapReplaceValues,
    ).toStartWithLowerCase();
    final fullFileName = Path.join(
      filePath,
      fileName,
    );

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
