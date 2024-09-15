import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/columns_autoincrement_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('id')],
  );

  final autoIncrementColumnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('id', autoIncrement: true)],
  );

  final statementWithoutColumns = CreateTableStatement(
    tableName: 'my_table_name',
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinition],
  );

  final statementWithAutoIncrement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [autoIncrementColumnDefinition],
  );

  group(
    'ColumnsAutoIncrementAssignmentGenerator',
    () => {
      test('without columns generate empty string', () {
        const expected = '';

        final result = ColumnsAutoIncrementAssignmentGenerator()(
          statementWithoutColumns,
        );

        expect(result, equals(expected));
      }),
      test('with simple column generates empty string', () {
        const expected = '';

        final result = ColumnsAutoIncrementAssignmentGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
      test('with auto increment generates valid assignment', () {
        const expected = '''

    if (id != null) {
      map[myTableNameColumnId] = id;
    }
''';

        final result = ColumnsAutoIncrementAssignmentGenerator()(
          statementWithAutoIncrement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
