import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/get_all/table_to_method_get_all_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final statement = CreateTableStatement(
    tableName: 'my_table_name',
  );

  group(
    'TableToMethodGetAllGenerator',
    () => {
      test('generates valid method with primary int column', () {
        const expected = '''
  Future<List<MyTableName>> getAll() async {
    final maps = await db.query(myTableNameTable);

    return maps.isEmpty
      ? []
      : maps.map((element) => MyTableName.fromMap(element)).toList();
  }
''';

        final result = TableToMethodGetAllGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
