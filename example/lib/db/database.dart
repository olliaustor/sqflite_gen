import 'package:example_app/db/tables/car_options/car_options_values.dart';
import 'package:example_app/db/tables/car_parts/car_parts_values.dart';
import 'package:example_app/db/tables/car_vins/car_vins_values.dart';
import 'package:example_app/db/tables/customer_ownership/customer_ownership_values.dart';
import 'package:example_app/db/tables/customers/customers_values.dart';
import 'package:example_app/db/tables/dealer_brand/dealer_brand_values.dart';
import 'package:example_app/db/tables/dealers/dealers_values.dart';
import 'package:example_app/db/tables/manufacture_plant/manufacture_plant_values.dart';
import 'package:example_app/db/tables/models/models_values.dart';

import 'tables/brands/brands_values.dart';
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
  final tables = _getTableProviders(db);

  for (final table in tables) {
    scriptList.addAll(table(version));
  }

  final batch = db.batch();
  for (final command in scriptList) {
    batch.execute(command);
  }
  await batch.commit(noResult: true);
}

List<GetTableProvider> _getTableProviders(Database db) {
  return [
    (int version) => [customersTableCreate],
    (int version) => [carVinsTableCreate],
    (int version) => [carOptionsTableCreate],
    (int version) => [carPartsTableCreate],
    (int version) => [brandsTableCreate],
    (int version) => [modelsTableCreate],
    (int version) => [customerOwnershipTableCreate],
    (int version) => [manufacturePlantTableCreate],
    (int version) => [dealersTableCreate],
    (int version) => [dealerBrandTableCreate],
  ];
}

    