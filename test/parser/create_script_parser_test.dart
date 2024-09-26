import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/parser/create_script_parser.dart';
import 'package:test/test.dart';

void main() {
  const invalidCreateTable = '''
  CREATE TABLE groups (
    group_id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL
  );
''';

  const validCreateTable = '''
      CREATE TABLE frameworks (
        id INTEGER NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        popularity REAL NOT NULL
      );
      ''';

  const validCreateTableWithAutoIncrement = '''
      CREATE TABLE languages (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
      ''';

  test('parses valid create statement', () {
    final parser = CreateScriptParser();

    final createTableStmt = parser.parse(validCreateTable);

    expect(createTableStmt[0].asLeft().tableName, 'frameworks');
  });

  test('parses invalid create statement and throws exception', () {
    final parser = CreateScriptParser();

    final createTableStmt = parser.parse(invalidCreateTable);

    expect(createTableStmt[0].isRight(), true);
  });

  test('parses multipleStatements', () {
    final parser = CreateScriptParser();

    final createTableStmt =
        parser.parse('$validCreateTable\n\n$validCreateTableWithAutoIncrement');

    expect(createTableStmt.length, 2);
  });
}
