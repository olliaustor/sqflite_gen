import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/create/table_to_method_create_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinition],
  );

  group(
    'TableToConstructorGenerator',
    () => {
      test('generates valid constructor from given parameters', () {
        const expected = '''
  List<String> create(int version) {
    return [myTableNameTableCreate];
  }
''';

        final result = TableToMethodCreateGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
