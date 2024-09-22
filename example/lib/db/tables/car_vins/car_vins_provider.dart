import '../../generic_provider.dart';
import 'car_vins_model.dart';
import 'car_vins_values.dart';
import 'package:sqflite/sqflite.dart';

class CarVinsProvider {
  CarVinsProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [carVinsTableCreate];
  }

  Future<CarVins> insert(CarVins carVins) async {
    final result = await db.insert(carVinsTable, carVins.toMap());
    
    return carVins.copyWith(vin: result);
  }

  Future<CarVins?> get(int vin) async {
    final maps = await db.query(carVinsTable,
      where: '\$carVinsColumnVin = ?',
      whereArgs: [vin],);

    return maps.isEmpty
      ? null
      : CarVins.fromMap(maps.first);
  }

  Future<bool> delete(int vin) async {
    final result = db.delete(carVinsTable,
      where: '\$carVinsColumnVin = ?',
      whereArgs: [vin],);
      
    return result > 0;  
  }

  Future<bool> update(CarVins carVins) async {
    final result = db.update(carVinsTable, carVins.toMap(),
      where: '\$carVinsColumnVin = ?',
      whereArgs: [carVins.vin],);
      
    return result > 0;  
  }

