import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/table_create_call_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final validStatement = CreateTableStatement(
    tableName: 'example_table',
  );

  group(
    'TableCreateCallGenerator',
    () => {
      test('builds valid create call', () {
        final generator = TableCreateCallGenerator();
        final result = generator(validStatement);

        expect(
          result,
          equals('(int version) => [exampleTableTableCreate]'),
        );
      }),
    },
  );
}
