import '../../generic_provider.dart';
import 'car_options_model.dart';
import 'car_options_values.dart';
import 'package:sqflite/sqflite.dart';

class CarOptionsProvider implements GenericProvider<CarOptions> {
  CarOptionsProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [carOptionsTableCreate];
  }

  @override
  Future<CarOptions> insert(CarOptions carOptions) async {
    final result = await db.insert(carOptionsTable, carOptions.toMap());
       
    return carOptions.copyWith(optionSetId: result);
  }

  @override
  Future<CarOptions?> get(int optionSetId) async {
    final maps = await db.query(carOptionsTable,
      where: '$carOptionsColumnOptionSetId = ?',
      whereArgs: [optionSetId],);

    if (maps.isNotEmpty) {
      return CarOptions.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int optionSetId) async {
    return db.delete(carOptionsTable,
      where: '$carOptionsColumnOptionSetId = ?',
      whereArgs: [optionSetId],);
  }

  @override
  Future<int> update(CarOptions carOptions) async {
    return db.update(carOptionsTable, carOptions.toMap(),
      where: '$carOptionsColumnOptionSetId = ?',
      whereArgs: [carOptions.optionSetId],);
  }
}
