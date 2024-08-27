import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/generators/file_generators/database/database_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final validStatement = [
    Either<CreateTableStatement, String>.left(
      CreateTableStatement(
        tableName: 'example_table',
      ),
    ),
  ];

  group('DatabaseGenerator', () => {
    test('has valid target filename', () async {
      final generator = DatabaseGenerator(validStatement);
      final result = await generator.generate();

      expect(result.targetFileName, equals('database.dart'));
    }),

    test('contains valid imports', () async {
      const expected = '''
import 'generic_provider.dart';
import 'tables/tables.dart';
import 'package:sqflite/sqflite.dart';
''';

      final generator = DatabaseGenerator(validStatement);
      final result = await generator.generate();

      expect(result.content, contains(expected));
    }),
    test('contains method openDatabaseWithMigration', () async {
      const expected = '''
Future<Database> openDatabaseWithMigration(String path) async {
  return openDatabase(path,
    version: 1,
    onCreate: _onCreate,
  );
}
''';

      final generator = DatabaseGenerator(validStatement);
      final result = await generator.generate();

      expect(result.content, contains(expected));
    }),
    test('contains method _onCreate', () async {
      const expected = '''
Future<void> _onCreate(Database db, int version) async {
  final scriptList = <String>[];
  final tables = _getTableProviders(db);

  for (final table in tables) {
    scriptList.addAll(table.create(version));
  }

  final batch = db.batch();
  for (final command in scriptList) {
    batch.execute(command);
  }
  await batch.commit(noResult: true);
}
''';
      final generator = DatabaseGenerator(validStatement);
      final result = await generator.generate();

      expect(result.content, contains(expected));
    }),
    test('contains method _getTableProviders', () async {
      final generator = DatabaseGenerator(validStatement);
      final result = await generator.generate();

      expect(result.content, contains('_getTableProviders'));
    }),
  });
}
