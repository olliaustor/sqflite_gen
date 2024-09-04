import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/constructor/table_to_constructor_generator.dart';
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
  MyTableName({
    this.id,
  });''';

        final result = TableToConstructorGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
