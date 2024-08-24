import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/method_get_tables_provider_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/utils.dart';
import 'package:sqlparser/sqlparser.dart';

class DatabaseGenerator extends FileGenerator {
  DatabaseGenerator(this.statements);

  final List<Either<CreateTableStatement, String>> statements;

  final String targetFileName = 'database.dart';

  final placeholderGetTableProvider = '%getTableProviders%';

  final content = '''
import 'generic_provider.dart';
import 'tables/tables.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDatabaseWithMigration(String path) async {
  return openDatabase(path,
    version: 1,
    onCreate: _onCreate,
  );
}

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

%getTableProviders%
    ''';

  @override
  Future<FileGeneratorResult> generate() async {
    final methodGetTableProviders =
      MethodGetTablesProviderGenerator();

    final fileContent = content.replaceAll(
      placeholderGetTableProvider,
      methodGetTableProviders(
        getValidTableStatements(statements),
      ),
    );

    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: fileContent,
    );
  }
}
