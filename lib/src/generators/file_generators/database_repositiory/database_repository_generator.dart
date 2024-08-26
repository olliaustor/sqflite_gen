import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

/// Generates file for accessing the database inside of the table
/// repositories
class DatabaseRepositoryGenerator extends FileGenerator {
  /// Output file name of generated file
  final String targetFileName = 'database_repository.dart';

  /// placeholder for the database file name
  final String databaseNamePlaceholder = '%databaseName%';

  /// Default database name
  final String databaseName = 'database.db';

  /// Content of output file with dynamic placeholders (to be replaced)
  final content = '''
import 'dart:async';

import 'database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseRepository {
  static Database? _database;
  String? path;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _open();
    return _database!;
  }

  Future<Database> _open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, '%databaseName%');

    return openDatabaseWithMigration(path);
  }
}
    ''';

  @override
  Future<FileGeneratorResult> generate() async {
    final targetContent = content.replaceAll(
      databaseNamePlaceholder,
      databaseName,
    );

    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: targetContent,
    );
  }
}
