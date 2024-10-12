import 'package:sqflite_gen/src/generators/file_generators/table_model/table_model_generator.dart';
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
  final generator = TableModelGenerator(
    createTableStmt[0],
  );

  group(
    'TableModelGenerator',
    () => {
      test('has valid target filename', () async {
        const expected = 'tables/frameworks/frameworks_model.dart';
        final result = await generator.generate();

        expect(result.targetFileName, equals(expected));
      }),
      test('has four exports', () async {
        final result = await generator.generate();

        final regEx = RegExp('import');
        final amount = regEx.allMatches(result.content).length;
        expect(amount, equals(4));
      }),
      test('contains ...dart:ffi import', () async {
        const expectedValue = "import 'dart:ffi';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains ...dart:typed_data import', () async {
        const expectedValue = "import 'dart:typed_data';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains ..._values.dart import', () async {
        const expectedValue = "import 'frameworks_values.dart';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains utils.dart import', () async {
        const expectedValue = "import '../../utils.dart';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains valid class declaration', () async {
        const expectedValue = 'class Frameworks {\n';

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains constructor', () async {
        const expectedValue = '''
  Frameworks({
    required this.id,
    required this.name,
    required this.popularity,
  });''';

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains field for id', () async {
        const expectedValue = 'final int id;\n';

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains field for name', () async {
        const expectedValue = 'final String name;\n';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains field for popularity', () async {
        const expectedValue = 'final Double popularity;\n';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains method toMap', () async {
        const expectedValue = 'Map<String, Object?> toMap() {\n';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains method fromMap', () async {
        const expectedValue =
            'factory Frameworks.fromMap(Map<String, Object?> map) {\n';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains method copyWith', () async {
        const expectedValue = 'Frameworks copyWith({\n';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('creates valid file', () async {
        const expectedValue = '''
import 'dart:ffi';
import 'dart:typed_data';

import 'frameworks_values.dart';
import '../../utils.dart';

class Frameworks {
''';
        final result = await generator.generate();

        expect(result.content, startsWith(expectedValue));
      }),
    },
  );
}
