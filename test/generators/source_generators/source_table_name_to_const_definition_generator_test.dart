import 'package:sqflite_gen/src/generators/source_generators/source_table_name_to_const_definition_generator.dart';
import 'package:test/test.dart';

void main() {
  group(
    'SourceTableNameToConstDefinitionGenerator',
        () => {
      test('table converts to const tableTable = \'table\';', () {
        final generator = SourceTableNameToConstDefinitionGenerator('table');
        final result = generator.generate();
        expect(result, equals('const String tableTable = \'table\';'));
      }),
      test('table_name converts to const tableNameTable = \'table_name\';', () {
        final generator = SourceTableNameToConstDefinitionGenerator('table_name');
        final result = generator.generate();
        expect(result, equals('const String tableNameTable = \'table_name\';'));
      }),
      test('Table converts to const tableTable = \'Table\';', () {
        final generator = SourceTableNameToConstDefinitionGenerator('Table');
        final result = generator.generate();
        expect(result, equals('const String tableTable = \'Table\';'));
      }),
      test('Table_Name converts to const tableNameTable = \'Table_Name\';', () {
        final generator = SourceTableNameToConstDefinitionGenerator('Table_Name');
        final result = generator.generate();
        expect(result, equals('const String tableNameTable = \'Table_Name\';'));
      }),
      test('TableName converts to const tableNameTable = \'TableName\';', () {
        final generator = SourceTableNameToConstDefinitionGenerator('TableName');
        final result = generator.generate();
        expect(result, equals('const String tableNameTable = \'TableName\';'));
      }),
    },
  );
}
