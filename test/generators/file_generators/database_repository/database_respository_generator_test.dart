import 'package:sqflite_gen/src/generators/file_generators/database_repositiory/database_repository_generator.dart';
import 'package:test/test.dart';

void main() {
  group('DatabaseRepositoryGenerator', () => {
    test('has valid target filename', () async {
      final generator = DatabaseRepositoryGenerator();
      final result = await generator.generate();

      expect(result.targetFileName, equals('database_repository.dart'));
    }),

    test('contains valid imports', () async {
      const expected = '''
import 'dart:async';

import 'database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
''';

      final generator = DatabaseRepositoryGenerator();
      final result = await generator.generate();

      expect(result.content, contains(expected));
    }),

    test('contains class DatabaseRepository', () async {
      const expected = 'class DatabaseRepository';

      final generator = DatabaseRepositoryGenerator();
      final result = await generator.generate();

      expect(result.content, contains(expected));
    }),
    test('contains getter database', () async {
      final expected = '''
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _open();
    return _database!;
  }
''';
      final generator = DatabaseRepositoryGenerator();
      final result = await generator.generate();

      expect(result.content, contains(expected));
    }),
    test('contains method _open', () async {
      const expected = '''
  Future<Database> _open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'database.db');

    return openDatabaseWithMigration(path);
  }
''';
      final generator = DatabaseRepositoryGenerator();
      final result = await generator.generate();

      expect(result.content, contains(expected));
    }),
  });
}
