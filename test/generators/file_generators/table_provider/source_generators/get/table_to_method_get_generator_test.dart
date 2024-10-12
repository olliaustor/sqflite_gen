import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/get/table_to_method_get_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionPkInt = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('id', autoIncrement: true)],
  );

  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
  );

  final columnDefinitionPkString = ColumnDefinition(
    columnName: 'id',
    typeName: 'STRING',
    constraints: [PrimaryKeyColumn('id')],
  );

  final statementPkInt = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinitionPkInt],
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
    'TableToMethodGetGenerator',
    () => {
      test('generates valid method with primary int column', () {
        const expected = r'''
  Future<MyTableName?> get(int id) async {
    final maps = await db.query(myTableNameTable,
      where: '$myTableNameColumnId = ?',
      whereArgs: [id],);

    return maps.isEmpty
      ? null
      : MyTableName.fromMap(maps.first);
  }
''';

        final result = TableToMethodGetGenerator()(
          statementPkInt,
        );

        expect(result, equals(expected));
      }),
      test('generates valid method with primary string column', () {
        const expected = r'''
  Future<MyTableName?> get(String id) async {
    final maps = await db.query(myTableNameTable,
      where: '$myTableNameColumnId = ?',
      whereArgs: [id],);

    return maps.isEmpty
      ? null
      : MyTableName.fromMap(maps.first);
  }
''';

        final result = TableToMethodGetGenerator()(
          statementPkString,
        );

        expect(result, equals(expected));
      }),
      test('generates empty string without primary column', () {
        const expected = '';

        final result = TableToMethodGetGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
