import '../../generic_provider.dart';
import 'car_vins_model.dart';
import 'car_vins_values.dart';
import 'package:sqflite/sqflite.dart';

class CarVinsProvider implements GenericProvider<CarVins> {
  CarVinsProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [carVinsTableCreate];
  }

  @override
  Future<CarVins> insert(CarVins carVins) async {
    final result = await db.insert(carVinsTable, carVins.toMap());
       
    return carVins.copyWith(vin: result);
  }

  @override
  Future<CarVins?> get(int vin) async {
    final maps = await db.query(carVinsTable,
      where: '$carVinsColumnVin = ?',
      whereArgs: [vin],);

    if (maps.isNotEmpty) {
      return CarVins.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int vin) async {
    return db.delete(carVinsTable,
      where: '$carVinsColumnVin = ?',
      whereArgs: [vin],);
  }

  @override
  Future<int> update(CarVins carVins) async {
    return db.update(carVinsTable, carVins.toMap(),
      where: '$carVinsColumnVin = ?',
      whereArgs: [carVins.vin],);
  }
}
