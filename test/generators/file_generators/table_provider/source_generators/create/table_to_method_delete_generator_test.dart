import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/create/table_to_method_delete_generator.dart';
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
    'TableToMethodDeleteGenerator',
    () => {
      test('generates valid method with primary int column', () {
        const expected = r'''
  Future<bool> delete(int id) async {
    final result = db.delete(myTableNameTable,
      where: '\$myTableNameColumnId = ?',
      whereArgs: [id],);
      
    return result > 0;  
  }
''';

        final result = TableToMethodDeleteGenerator()(
          statementPkInt,
        );

        expect(result, equals(expected));
      }),
      test('generates valid method with primary string column', () {
        const expected = r'''
  Future<bool> delete(String id) async {
    final result = db.delete(myTableNameTable,
      where: '\$myTableNameColumnId = ?',
      whereArgs: [id],);
      
    return result > 0;  
  }
''';

        final result = TableToMethodDeleteGenerator()(
          statementPkString,
        );

        expect(result, equals(expected));
      }),
      test('generates empty string without primary column', () {
        const expected = '';

        final result = TableToMethodDeleteGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
