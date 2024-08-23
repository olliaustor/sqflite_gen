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
    CustomersProvider(),
    CarVinsProvider(),
    CarOptionsProvider(),
    CarPartsProvider(),
    BrandsProvider(),
    ModelsProvider(),
    CustomerOwnershipProvider(),
    ManufacturePlantProvider(),
    DealersProvider(),
    DealerBrandProvider(),  
  ];
}

    