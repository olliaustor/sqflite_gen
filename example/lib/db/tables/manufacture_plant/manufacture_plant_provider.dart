import '../../generic_provider.dart';
import 'manufacture_plant_model.dart';
import 'manufacture_plant_values.dart';
import 'package:sqflite/sqflite.dart';

class ManufacturePlantProvider implements GenericProvider<ManufacturePlant> {
  ManufacturePlantProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [manufacturePlantTableCreate];
  }

  @override
  Future<ManufacturePlant> insert(ManufacturePlant manufacturePlant) async {
    final result = await db.insert(manufacturePlantTable, manufacturePlant.toMap());
       
    return manufacturePlant.copyWith(manufacturePlantId: result);
  }

  @override
  Future<ManufacturePlant?> get(int manufacturePlantId) async {
    final maps = await db.query(manufacturePlantTable,
      where: '$manufacturePlantColumnManufacturePlantId = ?',
      whereArgs: [manufacturePlantId],);

    if (maps.isNotEmpty) {
      return ManufacturePlant.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int manufacturePlantId) async {
    return db.delete(manufacturePlantTable,
      where: '$manufacturePlantColumnManufacturePlantId = ?',
      whereArgs: [manufacturePlantId],);
  }

  @override
  Future<int> update(ManufacturePlant manufacturePlant) async {
    return db.update(manufacturePlantTable, manufacturePlant.toMap(),
      where: '$manufacturePlantColumnManufacturePlantId = ?',
      whereArgs: [manufacturePlant.manufacturePlantId],);
  }
}
