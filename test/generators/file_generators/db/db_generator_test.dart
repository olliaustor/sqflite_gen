import 'package:sqflite_gen/src/generators/file_generators/db/db_generator.dart';
import 'package:test/test.dart';

void main() {
  group(
    'DbGenerator',
    () => {
      test('has valid target filename', () async {
        final generator = DbGenerator();
        final result = await generator.generate();

        expect(result.targetFileName, equals('db.dart'));
      }),
      test('contains valid content', () async {
        const expected = '''
export 'database_repository.dart';
export 'tables/tables.dart';
''';

        final generator = DbGenerator();
        final result = await generator.generate();

        expect(result.content, contains(expected));
      }),
    },
  );
}
