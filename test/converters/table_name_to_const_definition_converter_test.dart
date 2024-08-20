import 'package:sqflite_gen/src/converters/table_name_to_const_definition_converter.dart';
import 'package:test/test.dart';

void main() {
  group(
    'TableNameToConstDefinitionConverter',
        () => {
      test('table converts to const tableTable = \'table\';', () {
        final converter = TableNameToConstDefinitionConverter();
        final result = converter.convert('table');
        expect(result, equals('const String tableTable = \'table\';'));
      }),
      test('table_name converts to const tableNameTable = \'table_name\';', () {
        final converter = TableNameToConstDefinitionConverter();
        final result = converter.convert('table_name');
        expect(result, equals('const String tableNameTable = \'table_name\';'));
      }),
      test('Table converts to const tableTable = \'Table\';', () {
        final converter = TableNameToConstDefinitionConverter();
        final result = converter.convert('Table');
        expect(result, equals('const String tableTable = \'Table\';'));
      }),
      test('Table_Name converts to const tableNameTable = \'Table_Name\';', () {
        final converter = TableNameToConstDefinitionConverter();
        final result = converter.convert('Table_Name');
        expect(result, equals('const String tableNameTable = \'Table_Name\';'));
      }),
      test('TableName converts to const tableNameTable = \'TableName\';', () {
        final converter = TableNameToConstDefinitionConverter();
        final result = converter.convert('TableName');
        expect(result, equals('const String tableNameTable = \'TableName\';'));
      }),
    },
  );
}
