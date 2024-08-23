import '../../generic_provider.dart';
import 'dealer_brand_model.dart';
import 'dealer_brand_values.dart';
import 'package:sqflite/sqflite.dart';

class DealerBrandProvider implements GenericProvider<DealerBrand> {
  DealerBrandProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [dealerBrandTableCreate];
  }

  @override
  Future<DealerBrand> insert(DealerBrand dealerBrand) async {
    final result = await db.insert(dealerBrandTable, dealerBrand.toMap());
       
    return dealerBrand.copyWith(unknown: result);
  }

  @override
  Future<DealerBrand?> get(int unknown) async {
    final maps = await db.query(dealerBrandTable,
      where: '$unknown = ?',
      whereArgs: [unknown],);

    if (maps.isNotEmpty) {
      return DealerBrand.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int unknown) async {
    return db.delete(dealerBrandTable,
      where: '$unknown = ?',
      whereArgs: [unknown],);
  }

  @override
  Future<int> update(DealerBrand dealerBrand) async {
    return db.update(dealerBrandTable, dealerBrand.toMap(),
      where: '$unknown = ?',
      whereArgs: [dealerBrand.unknown],);
  }
}
