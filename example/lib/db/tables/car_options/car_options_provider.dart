import '../../generic_provider.dart';
import 'car_options_model.dart';
import 'car_options_values.dart';
import 'package:sqflite/sqflite.dart';

class CarOptionsProvider {
  CarOptionsProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [carOptionsTableCreate];
  }

  Future<CarOptions> insert(CarOptions carOptions) async {
    final result = await db.insert(carOptionsTable, carOptions.toMap());
    
    return carOptions.copyWith(optionSetId: result);
  }

  Future<CarOptions?> get(int optionSetId) async {
    final maps = await db.query(carOptionsTable,
      where: '\$carOptionsColumnOptionSetId = ?',
      whereArgs: [optionSetId],);

    return maps.isEmpty
      ? null
      : CarOptions.fromMap(maps.first);
  }

  Future<bool> delete(int optionSetId) async {
    final result = db.delete(carOptionsTable,
      where: '\$carOptionsColumnOptionSetId = ?',
      whereArgs: [optionSetId],);
      
    return result > 0;  
  }

  Future<bool> update(CarOptions carOptions) async {
    final result = db.update(carOptionsTable, carOptions.toMap(),
      where: '\$carOptionsColumnOptionSetId = ?',
      whereArgs: [carOptions.optionSetId],);
      
    return result > 0;  
  }

