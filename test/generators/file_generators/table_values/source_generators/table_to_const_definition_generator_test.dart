import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/table_to_const_definition_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'TableToConstDefinitionGenerator',
    () => {
      test('generates valid const definition from given [statement]', () {
        const expected = "const String frameworkTable = 'framework';";
        final statement = CreateTableStatement(
          tableName: 'framework',
        );

        final result = TableToConstDefinitionGenerator()(statement);

        expect(result, equals(expected));
      }),
    },
  );
}
