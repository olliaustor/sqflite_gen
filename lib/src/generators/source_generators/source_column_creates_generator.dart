import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqflite_gen/src/mappers/column_name_mapper.dart';
import 'package:sqlparser/sqlparser.dart';

class SourceColumnCreatesGenerator extends SourceGenerator {
  SourceColumnCreatesGenerator(
      String this.tableName, List<ColumnDefinition> this.columnDefinitions) {}

  final String tableName;
  final List<ColumnDefinition> columnDefinitions;

  @override
  String generate() {
    final sb = StringBuffer();
    for (final columnDefinition in columnDefinitions) {
      sb.writeln(_getColumnReplacement(tableName, columnDefinition).value);
    }

    return sb.toString().trimRight();
  }

  MapEntry<String, String> _getColumnReplacement(
      String tableName, ColumnDefinition columnDefinition) {
    final value = columnDefinition
        .toString()
        .replaceAll('ColumnDefinition: ', '')
        .replaceAll(columnDefinition.columnName, '')
        .toUpperCase();

    return MapEntry(
      columnDefinition.columnName,
      ' \$${_getConstColumnName(tableName, columnDefinition.columnName)}$value,',
    );
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
