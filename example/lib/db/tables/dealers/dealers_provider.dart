import '../../generic_provider.dart';
import 'dealers_model.dart';
import 'dealers_values.dart';
import 'package:sqflite/sqflite.dart';

class DealersProvider implements GenericProvider<Dealers> {
  DealersProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [dealersTableCreate];
  }

  @override
  Future<Dealers> insert(Dealers dealers) async {
    final result = await db.insert(dealersTable, dealers.toMap());
       
    return dealers.copyWith(dealerId: result);
  }

  @override
  Future<Dealers?> get(int dealerId) async {
    final maps = await db.query(dealersTable,
      where: '$dealersColumnDealerId = ?',
      whereArgs: [dealerId],);

    if (maps.isNotEmpty) {
      return Dealers.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int dealerId) async {
    return db.delete(dealersTable,
      where: '$dealersColumnDealerId = ?',
      whereArgs: [dealerId],);
  }

  @override
  Future<int> update(Dealers dealers) async {
    return db.update(dealersTable, dealers.toMap(),
      where: '$dealersColumnDealerId = ?',
      whereArgs: [dealers.dealerId],);
  }
}
