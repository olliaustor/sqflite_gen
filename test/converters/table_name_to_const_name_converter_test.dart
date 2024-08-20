import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:test/test.dart';

void main() {
  group(
    'TableNameToConstNameConverter',
        () => {
      test('table converts to tableTable', () {
        final converter = TableNameToConstNameConverter();
        final result = converter.convert('table');
        expect(result, equals('tableTable'));
      }),
      test('table_name converts to tableNameTable', () {
        final converter = TableNameToConstNameConverter();
        final result = converter.convert('table_name');
        expect(result, equals('tableNameTable'));
      }),
      test('Table converts to tableTable', () {
        final converter = TableNameToConstNameConverter();
        final result = converter.convert('Table');
        expect(result, equals('tableTable'));
      }),
      test('Table_Name converts to tableNameTable', () {
        final converter = TableNameToConstNameConverter();
        final result = converter.convert('Table_Name');
        expect(result, equals('tableNameTable'));
      }),
      test('TableName converts to tableNameTable', () {
        final converter = TableNameToConstNameConverter();
        final result = converter.convert('TableName');
        expect(result, equals('tableNameTable'));
      }),
    },
  );
}
