import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/list_of_table_providers_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final emptyStatements = <CreateTableStatement>[];
  final validStatement = [
    CreateTableStatement(
      tableName: 'example_table',
    ),
  ];
  final validStatements = [
    CreateTableStatement(
      tableName: 'example_table',
    ),
    CreateTableStatement(
      tableName: 'another_table',
    ),
  ];

  group(
    'ListOfTableProvidersGenerator',
    () => {
      test('with empty list generates empty string', () {
        final generator = ListOfTableProvidersGenerator();
        final result = generator(emptyStatements);

        expect(result, equals(''));
      }),
      test('with one table generates single line string', () {
        final generator = ListOfTableProvidersGenerator();
        final result = generator(validStatement);

        expect(
          result,
          equals('    (int version) => [exampleTableTableCreate],'),
        );
      }),
      test('with multiple tables generates multiline string', () {
        const expected = '''
    (int version) => [exampleTableTableCreate],
    (int version) => [anotherTableTableCreate],''';
        final generator = ListOfTableProvidersGenerator();
        final result = generator(validStatements);

        expect(result, equals(expected));
      }),
    },
  );
}
