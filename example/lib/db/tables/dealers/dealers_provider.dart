import '../../generic_provider.dart';
import 'dealers_model.dart';
import 'dealers_values.dart';
import 'package:sqflite/sqflite.dart';

class DealersProvider {
  DealersProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [dealersTableCreate];
  }

  Future<Dealers> insert(Dealers dealers) async {
    final result = await db.insert(dealersTable, dealers.toMap());
    
    return dealers.copyWith(dealerId: result);
  }

  Future<Dealers?> get(int dealerId) async {
    final maps = await db.query(dealersTable,
      where: '\$dealersColumnDealerId = ?',
      whereArgs: [dealerId],);

    return maps.isEmpty
      ? null
      : Dealers.fromMap(maps.first);
  }

  Future<bool> delete(int dealerId) async {
    final result = db.delete(dealersTable,
      where: '\$dealersColumnDealerId = ?',
      whereArgs: [dealerId],);
      
    return result > 0;  
  }

  Future<bool> update(Dealers dealers) async {
    final result = db.update(dealersTable, dealers.toMap(),
      where: '\$dealersColumnDealerId = ?',
      whereArgs: [dealers.dealerId],);
      
    return result > 0;  
  }

