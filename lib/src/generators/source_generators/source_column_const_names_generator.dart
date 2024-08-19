import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqflite_gen/src/mappers/column_name_mapper.dart';
import 'package:sqlparser/sqlparser.dart';

class SourceColumnConstNamesGenerator extends SourceGenerator {
  SourceColumnConstNamesGenerator(
      String this.tableName, List<ColumnDefinition> this.columnDefinitions) {}

  final String placeholderSqlColumnName = '%sqlColumnName%';
  final String placeholderConstColumnName = '%constColumnName%';

  final String constColumn =
      'const String %constColumnName% = \'%sqlColumnName%\';';

  final String tableName;
  final List<ColumnDefinition> columnDefinitions;

  @override
  String generate() {
    final sb = StringBuffer();
    for (final columnDefinition in columnDefinitions) {
      sb.writeln(_getConstColumnReplacement(tableName, columnDefinition).value);
    }

    return sb.toString().trimRight();
  }

  MapEntry<String, String> _getConstColumnReplacement(
      String sqlTableName, ColumnDefinition columnDefinition) {
    final sqlColumnName = columnDefinition.columnName;
    final constColumnName = _getConstColumnName(
      sqlTableName,
      sqlColumnName,
    );

    final value = constColumn
        .replaceAll(placeholderSqlColumnName, sqlColumnName)
        .replaceAll(placeholderConstColumnName, constColumnName);

    return MapEntry(columnDefinition.columnName, value);
  }

  String _getConstColumnName(String sqlTableName, String sqlColumnName) {
    final columnNameMapper = ColumnNameMapper(
      sqlTableName,
      sqlColumnName,
    );
    final result = columnNameMapper.map().value;

    return result;
  }
}
