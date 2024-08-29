import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
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
      '  \$${_getConstColumnName(tableName, columnDefinition.columnName)}$value,',
    );
  }

  String _getConstColumnName(String sqlTableName, String sqlColumnName) {
    final columnNameConverter =
      ColumnNameToConstNameConverter(sqlTableName);
    final result = columnNameConverter.convert(sqlColumnName);

    return result;
  }
}
