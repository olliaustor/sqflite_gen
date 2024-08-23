import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

class DatabaseGenerator extends FileGenerator {
  DatabaseGenerator(this.statements);

  final List<Either<CreateTableStatement, String>> statements;

  final String targetFileName = 'database.dart';

  final placeholderProvider = '%provider%';

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

List<GenericProvider<Object>> _getTableProviders(Database db) {
  return [
%provider%  
  ];
}

    ''';

  @override
  Future<FileGeneratorResult> generate() async {
    final fileContent = content.replaceAll(
      placeholderProvider,
      _getProvider(),
    );

    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: fileContent,
    );
  }

  String _getProvider() {
    final sb = StringBuffer();

    for (final item in statements.where((stmt) => stmt.isLeft())) {
      final statement = item.asLeft();
      final className = statement.toClassName();

      sb.writeln('    ${className}Provider(db),');
    }

    return sb.toString().trimRight();
  }
}
