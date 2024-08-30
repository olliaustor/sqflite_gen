import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/column_to_const_definition_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ColumnToConstDefinitionGenerator',
    () => {
      test('generates valid const definition from given parameters', () {
        const expected = "const String frameworkColumnId = 'id';";
        final statement = CreateTableStatement(
          tableName: 'framework',
        );
        final columnDefinition = ColumnDefinition(
          columnName: 'id',
          typeName: 'INT',
        );

        final result = ColumnToConstDefinitionGenerator()(
          statement,
          columnDefinition,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
