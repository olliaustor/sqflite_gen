import 'package:sqflite_gen/src/converters/column_name_to_const_definition_converter.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ColumnNameToConstDefinitionConverter',
        () => {
      test('table and column converts to const tableColumnColumn = \'column\';', () {
        final converter = ColumnNameToConstDefinitionConverter('table');
        final result = converter.convert('column');
        expect(result, equals('const String tableColumnColumn = \'column\';'));
      }),
      test('table_name and column_name converts to const tableNameColumnColumnName = \'column_name\';', () {
        final converter = ColumnNameToConstDefinitionConverter('table_name');
        final result = converter.convert('column_name');
        expect(result, equals('const String tableNameColumnColumnName = \'column_name\';'));
      }),
      test('Table and Column converts to const tableColumnColumn = \'Column\';', () {
        final converter = ColumnNameToConstDefinitionConverter('Table');
        final result = converter.convert('Column');
        expect(result, equals('const String tableColumnColumn = \'Column\';'));
      }),
      test('Table_Name and Column_Name converts to const tableNameColumnColumnName = \'Column_Name\';', () {
        final converter = ColumnNameToConstDefinitionConverter('Table_Name');
        final result = converter.convert('Column_Name');
        expect(result, equals('const String tableNameColumnColumnName = \'Column_Name\';'));
      }),
      test('TableName and ColumnName converts to const tableNameColumnColumnName = \'ColumnName\';', () async {
        final converter = ColumnNameToConstDefinitionConverter('TableName');
        final result = converter.convert('ColumnName');
        expect(result, equals('const String tableNameColumnColumnName = \'ColumnName\';'));
      }),
    },
  );
}
