import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/column_to_const_definition_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/column_to_const_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ColumnToConstNameGenerator',
    () => {
      test('generates valid const name from given parameters', () {
        const expected = 'frameworkColumnId';
        final statement = CreateTableStatement(
          tableName: 'framework',
        );
        final columnDefinition = ColumnDefinition(
          columnName: 'id',
          typeName: 'INT',
        );

        final result = ColumnToConstNameGenerator()(
          statement,
          columnDefinition,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
