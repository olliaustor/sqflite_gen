import 'package:sqflite_gen/src/generators/source_generators/source_column_name_to_const_definition_generator.dart';
import 'package:test/test.dart';

void main() {
  group(
    'SourceColumnNameToConstDefinitionGenerator',
        () => {
      test('table and column converts to const tableColumnColumn = \'column\';', () {
        final generator = SourceColumnNameToConstDefinitionGenerator('table', 'column',);
        final result = generator.generate();
        expect(result, equals('const String tableColumnColumn = \'column\';'));
      }),
      test('table_name and column_name converts to const tableNameColumnColumnName = \'column_name\';', () {
        final generator = SourceColumnNameToConstDefinitionGenerator('table_name','column_name',);
        final result = generator.generate();
        expect(result, equals('const String tableNameColumnColumnName = \'column_name\';'));
      }),
      test('Table and Column converts to const tableColumnColumn = \'Column\';', () {
        final generator = SourceColumnNameToConstDefinitionGenerator('Table', 'Column',);
        final result = generator.generate();
        expect(result, equals('const String tableColumnColumn = \'Column\';'));
      }),
      test('Table_Name and Column_Name converts to const tableNameColumnColumnName = \'Column_Name\';', () {
        final generator = SourceColumnNameToConstDefinitionGenerator('Table_Name', 'Column_Name', );
        final result = generator.generate();
        expect(result, equals('const String tableNameColumnColumnName = \'Column_Name\';'));
      }),
      test('TableName and ColumnName converts to const tableNameColumnColumnName = \'ColumnName\';', () async {
        final generator = SourceColumnNameToConstDefinitionGenerator('TableName', 'ColumnName',);
        final result = generator.generate();
        expect(result, equals('const String tableNameColumnColumnName = \'ColumnName\';'));
      }),
    },
  );
}
