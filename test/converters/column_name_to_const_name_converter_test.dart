import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ColumnNameToConstNameConverter',
    () => {
      test('table and column converts to tableColumnColumn', () {
        final converter = ColumnNameToConstNameConverter('table');
        final result = converter.convert('column');
        expect(result, equals('tableColumnColumn'));
      }),
      test('table_name and column_name converts to tableNameColumnColumnName',
          () {
        final converter = ColumnNameToConstNameConverter('table_name');
        final result = converter.convert('column_name');
        expect(result, equals('tableNameColumnColumnName'));
      }),
      test('Table and Column converts to tableColumnColumn', () {
        final converter = ColumnNameToConstNameConverter('Table');
        final result = converter.convert('Column');
        expect(result, equals('tableColumnColumn'));
      }),
      test('Table_Name and Column_Name converts to tableNameColumnColumnName',
          () {
        final converter = ColumnNameToConstNameConverter('Table_Name');
        final result = converter.convert('Column_Name');
        expect(result, equals('tableNameColumnColumnName'));
      }),
      test('TableName and ColumnName converts to tableNameColumnColumnName',
          () async {
        final converter = ColumnNameToConstNameConverter('TableName');
        final result = converter.convert('ColumnName');
        expect(result, equals('tableNameColumnColumnName'));
      }),
    },
  );
}
