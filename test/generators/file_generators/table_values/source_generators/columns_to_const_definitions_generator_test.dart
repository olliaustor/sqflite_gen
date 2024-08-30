import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/columns_to_const_definitions_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ColumnsToConstDefinitionsGenerator',
    () => {
      test('generates empty [String] without column', () {
        const expected = '';
        final statement = CreateTableStatement(
          tableName: 'framework',
        );

        final result = ColumnsToConstDefinitionsGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
      test('generates single line [String] with 1 column', () {
        const expected = "const String frameworkColumnId = 'id';";
        final columnDefinition = ColumnDefinition(
          columnName: 'id',
          typeName: 'INT',
        );
        final statement = CreateTableStatement(
          tableName: 'framework',
          columns: [columnDefinition],
        );

        final result = ColumnsToConstDefinitionsGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
      test('generates multi line [String] with multiple columns', () {
        const expected = '''
const String frameworkColumnId = 'id';
const String frameworkColumnName = 'name';''';
        final columnDefinitionA = ColumnDefinition(
          columnName: 'id',
          typeName: 'INT',
        );
        final columnDefinitionB = ColumnDefinition(
          columnName: 'name',
          typeName: 'STRING',
        );
        final statement = CreateTableStatement(
          tableName: 'framework',
          columns: [columnDefinitionA, columnDefinitionB],
        );

        final result = ColumnsToConstDefinitionsGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
