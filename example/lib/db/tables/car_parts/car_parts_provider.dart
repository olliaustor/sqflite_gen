import '../../generic_provider.dart';
import 'car_parts_model.dart';
import 'car_parts_values.dart';
import 'package:sqflite/sqflite.dart';

class CarPartsProvider implements GenericProvider<CarParts> {
  CarPartsProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [carPartsTableCreate];
  }

  @override
  Future<CarParts> insert(CarParts carParts) async {
    final result = await db.insert(carPartsTable, carParts.toMap());
       
    return carParts.copyWith(partId: result);
  }

  @override
  Future<CarParts?> get(int partId) async {
    final maps = await db.query(carPartsTable,
      where: '$carPartsColumnPartId = ?',
      whereArgs: [partId],);

    if (maps.isNotEmpty) {
      return CarParts.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int partId) async {
    return db.delete(carPartsTable,
      where: '$carPartsColumnPartId = ?',
      whereArgs: [partId],);
  }

  @override
  Future<int> update(CarParts carParts) async {
    return db.update(carPartsTable, carParts.toMap(),
      where: '$carPartsColumnPartId = ?',
      whereArgs: [carParts.partId],);
  }
}
