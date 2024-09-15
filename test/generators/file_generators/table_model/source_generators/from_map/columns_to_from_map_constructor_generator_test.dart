import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/from_map/columns_to_from_map_constructor_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionBool = ColumnDefinition(
    columnName: 'val_a',
    typeName: 'BOOL',
  );

  final columnDefinitionInt = ColumnDefinition(
    columnName: 'val_b',
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
    'ColumnsToFromMapConstructorGenerator',
    () => {
      test('empty list of columns returns simple constructor string', () {
        const expected = '''
    return MyTableName(

    );''';

        final result = ColumnsToFromMapConstructorGenerator()(
          statementEmpty,
        );

        expect(result, equals(expected));
      }),
      test('single column returns constructor with single parameter', () {
        const expected = '''
    return MyTableName(
      valA: valA,
    );''';

        final result = ColumnsToFromMapConstructorGenerator()(
          statementWithOneColumn,
        );

        expect(result, equals(expected));
      }),
      test('multiple columns returns constructor with multiple parameters', () {
        const expected = '''
    return MyTableName(
      valA: valA,
      valB: valB,
    );''';

        final result = ColumnsToFromMapConstructorGenerator()(
          statementWithMultipleColumns,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
