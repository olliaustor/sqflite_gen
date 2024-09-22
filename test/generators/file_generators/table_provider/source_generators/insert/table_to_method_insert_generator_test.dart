import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/insert/table_to_method_insert_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionPkInt = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('id', autoIncrement: true)],
  );

  final columnDefinitionPkNullable = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('id', autoIncrement: true), NotNull('id')],
  );

  final columnDefinitionPkString = ColumnDefinition(
    columnName: 'id',
    typeName: 'STRING',
    constraints: [PrimaryKeyColumn('id')],
  );

  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
  );

  final statementPkInt = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinitionPkInt],
  );

  final statementPkNullable = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinitionPkNullable],
  );

  final statementPkString = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinitionPkString],
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinition],
  );

  group(
    'TableToMethodInsertGenerator',
    () => {
      test('generates valid method with primary int column', () {
        const expected = '''
  Future<MyTableName> insert(MyTableName myTableName) async {
    final result = await db.insert(myTableNameTable, myTableName.toMap());
    
    return myTableName.copyWith(id: Wrapped.value(result));
  }
''';

        final result = TableToMethodInsertGenerator()(
          statementPkInt,
        );

        expect(result, equals(expected));
      }),
      test('generates valid method with primary column nullable', () {
        const expected = '''
  Future<MyTableName> insert(MyTableName myTableName) async {
    final result = await db.insert(myTableNameTable, myTableName.toMap());
    
    return myTableName.copyWith(id: result);
  }
''';

        final result = TableToMethodInsertGenerator()(
          statementPkNullable,
        );

        expect(result, equals(expected));
      }),
      test('generates valid method with primary string column', () {
        const expected = '''
  Future<MyTableName> insert(MyTableName myTableName) async {
    final result = await db.insert(myTableNameTable, myTableName.toMap());
    
    return myTableName;
  }
''';

        final result = TableToMethodInsertGenerator()(
          statementPkString,
        );

        expect(result, equals(expected));
      }),
      test('generates valid method without primary column', () {
        const expected = '''
  Future<MyTableName> insert(MyTableName myTableName) async {
    final result = await db.insert(myTableNameTable, myTableName.toMap());
    
    return myTableName;
  }
''';

        final result = TableToMethodInsertGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
