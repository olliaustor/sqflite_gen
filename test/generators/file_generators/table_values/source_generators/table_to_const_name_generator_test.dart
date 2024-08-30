import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/table_to_const_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'TableToConstNameGenerator',
    () => {
      test('generates valid table const name from given parameters', () {
        const expected = 'frameworkTable';
        final statement = CreateTableStatement(
          tableName: 'framework',
        );

        final result = TableToConstNameGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
