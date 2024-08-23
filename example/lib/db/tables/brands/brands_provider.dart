import '../../generic_provider.dart';
import 'brands_model.dart';
import 'brands_values.dart';
import 'package:sqflite/sqflite.dart';

class BrandsProvider implements GenericProvider<Brands> {
  BrandsProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [brandsTableCreate];
  }

  @override
  Future<Brands> insert(Brands brands) async {
    final result = await db.insert(brandsTable, brands.toMap());
       
    return brands.copyWith(brandId: result);
  }

  @override
  Future<Brands?> get(int brandId) async {
    final maps = await db.query(brandsTable,
      where: '$brandsColumnBrandId = ?',
      whereArgs: [brandId],);

    if (maps.isNotEmpty) {
      return Brands.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int brandId) async {
    return db.delete(brandsTable,
      where: '$brandsColumnBrandId = ?',
      whereArgs: [brandId],);
  }

  @override
  Future<int> update(Brands brands) async {
    return db.update(brandsTable, brands.toMap(),
      where: '$brandsColumnBrandId = ?',
      whereArgs: [brands.brandId],);
  }
}
