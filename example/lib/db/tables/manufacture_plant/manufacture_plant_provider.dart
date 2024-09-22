import '../../generic_provider.dart';
import 'manufacture_plant_model.dart';
import 'manufacture_plant_values.dart';
import 'package:sqflite/sqflite.dart';

class ManufacturePlantProvider {
  ManufacturePlantProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [manufacturePlantTableCreate];
  }

  Future<ManufacturePlant> insert(ManufacturePlant manufacturePlant) async {
    final result = await db.insert(manufacturePlantTable, manufacturePlant.toMap());
    
    return manufacturePlant.copyWith(manufacturePlantId: result);
  }

  Future<ManufacturePlant?> get(int manufacturePlantId) async {
    final maps = await db.query(manufacturePlantTable,
      where: '\$manufacturePlantColumnManufacturePlantId = ?',
      whereArgs: [manufacturePlantId],);

    return maps.isEmpty
      ? null
      : ManufacturePlant.fromMap(maps.first);
  }

  Future<bool> delete(int manufacturePlantId) async {
    final result = db.delete(manufacturePlantTable,
      where: '\$manufacturePlantColumnManufacturePlantId = ?',
      whereArgs: [manufacturePlantId],);
      
    return result > 0;  
  }

  Future<bool> update(ManufacturePlant manufacturePlant) async {
    final result = db.update(manufacturePlantTable, manufacturePlant.toMap(),
      where: '\$manufacturePlantColumnManufacturePlantId = ?',
      whereArgs: [manufacturePlant.manufacturePlantId],);
      
    return result > 0;  
  }

