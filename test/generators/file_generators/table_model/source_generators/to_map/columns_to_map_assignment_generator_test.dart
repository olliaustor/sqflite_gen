import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/columns_to_map_assignment_generator.dart';
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

  final columnDefinitionAutoIncrement = ColumnDefinition(
    columnName: 'valAuto',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('valAuto', autoIncrement: true)],
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

  final statementWithAutoIncrement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinitionInt, columnDefinitionAutoIncrement],
  );

  group(
    'ColumnsToMapAssignmentGenerator',
    () => {
      test('empty list of columns returns empty string', () {
        const expected = '';

        final result = ColumnsToMapAssignmentGenerator()(
          statementEmpty,
        );

        expect(result, equals(expected));
      }),
      test('single column returns simple string', () {
        final result = ColumnsToMapAssignmentGenerator()(
          statementWithOneColumn,
        );

        expect(result, isNot(contains('\n')));
      }),
      test('multiple columns returns multiline string', () {
        final result = ColumnsToMapAssignmentGenerator()(
          statementWithMultipleColumns,
        );

        expect(result, contains('\n'));
      }),
      test('exclude auto increment column from list', () {
        const expected = 'myTableNameColumnValAuto: valAuto';

        final result = ColumnsToMapAssignmentGenerator()(
          statementWithAutoIncrement,
        );

        expect(result, isNot(contains(expected)));
      }),
    },
  );
}
