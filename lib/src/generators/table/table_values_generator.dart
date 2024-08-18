import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';

import 'package:sqflite_gen/src/generators/generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

class TableValuesGenerator extends Generator {
  TableValuesGenerator(this.statement) {}

  final Either<CreateTableStatement, String> statement;

  final String targetDirectory = 'tables/%sqlTableName%';
  final String targetFileName = '%sqlTableName%_values.dart';

  final String constTableName = '%sqlTableName%TableName';
  final String columnName = '%sqlTableName%Column%sqlColumnName%';
  final String constTable =
      'const String %constTableName% = \'%sqlTableName%\'';
  final String constColumn =
      'const String %constColumnName% = \'%sqlColumnName%\';';

  final String placeholderSqlTableName = '%sqlTableName%';
  final String placeholderSqlColumnName = '%sqlColumnName%';
  final String placeholderConstTableName = '%constTableName%';
  final String placeholderConstColumnName = '%constColumnName%';
  final String placeholderConstColumns = '%const_columns%';
  final String placeholderColumnDefinitions = '%column_definitions%';

  final String createStatement = '''
const String %constTableName% = \'%sqlTableName%\';
%const_columns%

const String %sqlTableName%Create = \'\'\'
CREATE TABLE \$%constTableName% (
%column_definitions%
)
\'\'\';
  ''';

  @override
  Future<GeneratorResult> generate() async {
    final CreateTableStatement createTableStatement = statement.asLeft();
    final String sqlTableName = createTableStatement.tableName;

    final mapReplacements = [
      MapEntry(placeholderSqlTableName, sqlTableName),
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

    return GeneratorResult(
      targetFileName: fullFileName,
      content: content,
    );
  }

  MapEntry<String, String> _getSqlTableNameReplacementValue(
      String sqlTableName) {
    return MapEntry(placeholderSqlTableName, sqlTableName);
  }

  MapEntry<String, String> _getConstTableNameReplacementValue(
      String sqlTableName) {
    return MapEntry(
        placeholderConstTableName,
        constTableName.replaceAll(
          placeholderSqlTableName,
          sqlTableName,
        ));
  }

  MapEntry<String, String> _getConstColumnsReplacementValue(
      String tableName, List<ColumnDefinition> columnDefinitions) {
    final sb = StringBuffer();
    for (final columnDefinition in columnDefinitions) {
      sb.writeln(_getConstColumnReplacement(tableName, columnDefinition).value);
    }

    return MapEntry(placeholderConstColumns, sb.toString().trimRight());
  }

  MapEntry<String, String> _getConstColumnName(
      String tableName, ColumnDefinition columnDefinition) {
    final readableColumnName = columnDefinition.columnName
      .replaceAll('_', ' ')
      .toTitleCase()
      .replaceAll(' ', '');
    final value = columnName
        .replaceAll(placeholderSqlTableName, tableName)
        .replaceAll(placeholderSqlColumnName, readableColumnName);

    return MapEntry(columnDefinition.columnName, value);
  }

  MapEntry<String, String> _getConstColumnReplacement(
      String tableName, ColumnDefinition columnDefinition) {
    final value = constColumn
        .replaceAll(placeholderSqlColumnName, columnDefinition.columnName)
        .replaceAll(placeholderConstColumnName,
            _getConstColumnName(tableName, columnDefinition).value);

    return MapEntry(columnDefinition.columnName, value);
  }

  MapEntry<String, String> _getColumnsDefinitionReplacementValue(
      String tableName,
      List<ColumnDefinition> columnDefinitions) {
    final sb = StringBuffer();
    for (final columnDefinition in columnDefinitions) {
      sb.writeln(_getColumnReplacement(tableName, columnDefinition).value);
    }

    return MapEntry(placeholderColumnDefinitions, sb.toString().trimRight());
  }

  MapEntry<String, String> _getColumnReplacement(
      String tableName,
      ColumnDefinition columnDefinition) {
    final value = columnDefinition
        .toString()
        .replaceAll('ColumnDefinition: ', '')
        .replaceAll(columnDefinition.columnName, '')
        .toUpperCase();

    return MapEntry(columnDefinition.columnName,
        ' ' + '\$' + _getConstColumnName(tableName, columnDefinition).value + value + ',');
  }

  String _getFullFileName(List<MapEntry<String, String>> mapReplaceValues) {
    final filePath = _replaceAll(
      targetDirectory,
      mapReplaceValues,
    );
    final String fileName = _replaceAll(
      targetFileName,
      mapReplaceValues,
    );
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
    String text = source;

    for (final mapEntry in mapReplaceValues) {
      final key = mapEntry.key;
      final value = mapEntry.value;

      text = text.replaceAll(key, value);
    }

    return text;
  }
}
