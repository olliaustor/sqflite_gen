import 'package:sqflite_gen/src/generators/generator_base.dart';

class DatabaseRepositoryGenerator extends Generator {
  final String databaseNamePlaceholder = '%databaseName%';
  final String databaseName = 'database.db';
  final String targetFileName = 'database_repository.dart';

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
    final path = join(databasesPath, %databaseName%);

    return openDatabaseWithMigration(path);
  }
}
    ''';

  @override
  Future<GeneratorResult> generate() async {
    final targetContent = content.replaceAll(
      databaseNamePlaceholder,
      databaseName,
    );

    return GeneratorResult(
      targetFileName: targetFileName,
      content: targetContent,
    );
  }
}
