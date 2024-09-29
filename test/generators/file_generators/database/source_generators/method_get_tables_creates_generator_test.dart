import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/method_get_tables_provider_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final emptyStatements = <CreateTableStatement>[];
  final validStatements = [
    CreateTableStatement(
      tableName: 'example_table',
    ),
    CreateTableStatement(
      tableName: 'another_table',
    ),
  ];

  group(
    'MethodGetTablesCreatesGenerator',
    () => {
      test('with empty list generates valid method', () {
        const expected = '''
List<GetTableProvider> _getTableCreates(Database db) {
  return [

  ];
}
''';

        final generator = MethodGetTablesCreatesGenerator();
        final result = generator(emptyStatements);

        expect(result, equals(expected));
      }),
      test('with table generates valid method', () {
        const expected = '''
List<GetTableProvider> _getTableCreates(Database db) {
  return [
    (int version) => [exampleTableTableCreate],
    (int version) => [anotherTableTableCreate],
  ];
}
''';
        final generator = MethodGetTablesCreatesGenerator();
        final result = generator(validStatements);

        expect(result, equals(expected));
      }),
    },
  );
}
