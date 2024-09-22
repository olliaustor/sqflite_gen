import '../../utils.dart';  
import 'car_parts_model.dart';
import 'car_parts_values.dart';
import 'package:sqflite/sqflite.dart';

class CarPartsProvider {
  CarPartsProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [carPartsTableCreate];
  }

  Future<CarParts> insert(CarParts carParts) async {
    final result = await db.insert(carPartsTable, carParts.toMap());
    
    return carParts.copyWith(partId: Wrapped.value(result));
  }

  Future<CarParts?> get(int partId) async {
    final maps = await db.query(carPartsTable,
      where: '\$carPartsColumnPartId = ?',
      whereArgs: [partId],);

    return maps.isEmpty
      ? null
      : CarParts.fromMap(maps.first);
  }

  Future<bool> delete(int partId) async {
    final result = await db.delete(carPartsTable,
      where: '\$carPartsColumnPartId = ?',
      whereArgs: [partId],);
      
    return result > 0;  
  }

  Future<bool> update(CarParts carParts) async {
    final result = await db.update(carPartsTable, carParts.toMap(),
      where: '\$carPartsColumnPartId = ?',
      whereArgs: [carParts.partId],);
      
    return result > 0;  
  }

}
