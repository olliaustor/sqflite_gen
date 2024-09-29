import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/method_get_tables_provider_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/utils.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates a file which contains functions for initializing and accessing
/// the database.
/// This generates the entry point for the database usage in the target app.
class DatabaseGenerator extends FileGenerator {
  /// Creates new instance which uses given [statements]
  DatabaseGenerator(this.statements);

  /// Create table statements from sql file
  final List<Either<CreateTableStatement, String>> statements;

  /// Output file name of generated file
  final String targetFileName = 'database.dart';

  /// Placeholder for list of used table create statements
  final placeholderGetTableCreates = '%getTableCreates%';

  /// Content of output file (including dynamic parts)
  final content = '''
import 'tables/tables.dart';
import 'package:sqflite/sqflite.dart';

typedef GetTableProvider = List<String> Function(int);

Future<Database> openDatabaseWithMigration(String path) async {
  return openDatabase(path,
    version: 1,
    onCreate: _onCreate,
  );
}

Future<void> _onCreate(Database db, int version) async {
  final scriptList = <String>[];
  final tables = _getTableCreates(db);

  for (final table in tables) {
    scriptList.addAll(table(version));
  }

  final batch = db.batch();
  for (final command in scriptList) {
    batch.execute(command);
  }
  await batch.commit(noResult: true);
}

%getTableCreates%
    ''';

  @override
  Future<FileGeneratorResult> generate() async {
    final methodGetTableCreates = MethodGetTablesCreatesGenerator();

    final fileContent = content.replaceAll(
      placeholderGetTableCreates,
      methodGetTableCreates(
        getValidTableStatements(statements),
      ),
    );

    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: fileContent,
    );
  }
}
