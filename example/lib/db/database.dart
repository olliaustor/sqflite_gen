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

List<GetTableProvider> _getTableCreates(Database db) {
  return [
    (int version) => [testTableCreate],
  ];
}

    