import 'package:sqflite_gen/src/generators/file_generators/table_values/table_values_generator.dart';
import 'package:sqflite_gen/src/parser/create_script_parser.dart';
import 'package:test/test.dart';

void main() {
  const validCreateTable = '''
CREATE TABLE frameworks (
  id INTEGER NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  popularity REAL NOT NULL
);''';

  final parser = CreateScriptParser();
  final createTableStmt = parser.parse(
    validCreateTable,
  );
  final generator = TableValuesGenerator(
    createTableStmt[0],
  );

  group(
    'TableValuesGenerator',
    () => {
      test('has valid target filename', () async {
        const expected = 'tables/frameworks/frameworks_values.dart';
        final result = await generator.generate();

        expect(result.targetFileName, equals(expected));
      }),
      test('contains const for table name', () async {
        const expectedValue = "const String frameworksTable = 'frameworks';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains const for id column', () async {
        const expectedValue = "const String frameworksColumnId = 'id';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains const for name column', () async {
        const expectedValue = "const String frameworksColumnName = 'name';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains const for popularity column', () async {
        const expectedValue =
            "const String frameworksColumnPopularity = 'popularity';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains const for table creation', () async {
        const expectedValue = "const String frameworksTableCreate = '''\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains sql create table statement ', () async {
        final result = await generator.generate();

        expect(result.content, contains(validCreateTable));
      }),
      test('creates valid file', () async {
        const expectedValue = '''
const String frameworksTable = 'frameworks';
const String frameworksColumnId = 'id';
const String frameworksColumnName = 'name';
const String frameworksColumnPopularity = 'popularity';

const String frameworksTableCreate = \'\'\'
$validCreateTable
\'\'\';
''';
        final result = await generator.generate();

        expect(result.content, equals(expectedValue));
      }),
    },
  );
}
