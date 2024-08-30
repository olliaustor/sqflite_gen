import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/table_to_const_create_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'TableToConstCreateNameGenerator',
    () => {
      test('generates valid table const name from given parameters', () {
        const expected = 'frameworkTableCreate';
        final statement = CreateTableStatement(
          tableName: 'framework',
        );

        final result = TableToConstCreateNameGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
