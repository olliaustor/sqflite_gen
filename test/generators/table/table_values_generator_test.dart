import 'package:sqflite_gen/src/generators/table/table_values_generator.dart';
import 'package:sqflite_gen/src/parser/create_script_parser.dart';
import 'package:test/test.dart';

void main() {
  final String validCreateTable = '''
      CREATE TABLE frameworks (
        id INTEGER NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        popularity REAL NOT NULL
      );
      ''';

  group(
      'TableValuesGenerator',
      () => {
            test('includes const for table name', () async {
              final String expectedValue =
                  'const String frameworksTable = \'frameworks\';\n';

              final parser = CreateScriptParser();
              final createTableStmt = parser.parse(
                validCreateTable,
              );

              final generator = TableValuesGenerator(
                createTableStmt[0],
              );

              final result = await generator.generate();

              expect(result.content, contains(expectedValue));
            }),
            test('includes const for table creation', () async {
              final String expectedValue =
                  'const String frameworksTableCreate = \'\'\'\n';

              final parser = CreateScriptParser();
              final createTableStmt = parser.parse(
                validCreateTable,
              );

              final generator = TableValuesGenerator(
                createTableStmt[0],
              );

              final result = await generator.generate();

              expect(result.content, contains(expectedValue));
            }),
            test('includes create table statement', () async {
              final String expectedValue =
                  'CREATE TABLE \$frameworksTable (\n';

              final parser = CreateScriptParser();
              final createTableStmt = parser.parse(
                validCreateTable,
              );

              final generator = TableValuesGenerator(
                createTableStmt[0],
              );

              final result = await generator.generate();

              expect(result.content, contains(expectedValue));
            })
          });
}
