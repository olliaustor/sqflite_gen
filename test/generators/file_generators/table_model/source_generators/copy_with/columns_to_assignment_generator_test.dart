import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/copy_with/columns_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionBool = ColumnDefinition(
    columnName: 'val',
    typeName: 'BOOL',
  );

  final columnDefinitionInt = ColumnDefinition(
    columnName: 'val',
    typeName: 'INT',
  );

  final statementEmpty = CreateTableStatement(
    tableName: 'my_table_name',
  );

  final statementWithOneColumn = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinitionBool],
  );

  final statementWithMultipleColumns = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinitionBool, columnDefinitionInt],
  );

  group(
    'ColumnsToAssignmentGenerator',
    () => {
      test('empty list of columns returns empty string', () {
        const expected = '';

        final result = ColumnsToAssignmentGenerator()(
          statementEmpty,
        );

        expect(result, equals(expected));
      }),
      test('single column returns simple string', () {
        final result = ColumnsToAssignmentGenerator()(
          statementWithOneColumn,
        );

        expect(result, isNot(contains('\n')));
      }),
      test('multiple columns returns multiline string', () {
        final result = ColumnsToAssignmentGenerator()(
          statementWithMultipleColumns,
        );

        expect(result, contains('\n'));
      }),
    },
  );
}
