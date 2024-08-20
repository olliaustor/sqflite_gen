import 'package:sqflite_gen/src/converters/camel_case_to_underscore_converter.dart';
import 'package:test/test.dart';

void main() {
  group(
    'CamelCaseToUnderscoreConverter',
    () => {
      test('table converts to table', () {
        final converter = CamelCaseToUnderscoreConverter();
        final result = converter.convert('table');
        expect(result, equals('table'));
      }),
      test('table_name converts to table_name', () {
        final converter = CamelCaseToUnderscoreConverter();
        final result = converter.convert('table_name');
        expect(result, equals('table_name'));
      }),
      test('Table converts to table', () {
        final converter = CamelCaseToUnderscoreConverter();
        final result = converter.convert('Table');
        expect(result, equals('table'));
      }),
      test('Table_Name converts to table_name', () {
        final converter = CamelCaseToUnderscoreConverter();
        final result = converter.convert('Table_Name');
        expect(result, equals('table_name'));
      }),
      test('TableName converts to table_name', () {
        final converter = CamelCaseToUnderscoreConverter();
        final result = converter.convert('TableName');
        expect(result, equals('table_name'));
      }),
    },
  );
}
