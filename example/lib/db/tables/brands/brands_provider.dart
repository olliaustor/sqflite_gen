import '../../utils.dart';  
import 'brands_model.dart';
import 'brands_values.dart';
import 'package:sqflite/sqflite.dart';

class BrandsProvider {
  BrandsProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [brandsTableCreate];
  }

  Future<Brands> insert(Brands brands) async {
    final result = await db.insert(brandsTable, brands.toMap());
    
    return brands.copyWith(brandId: Wrapped.value(result));
  }

  Future<Brands?> get(int brandId) async {
    final maps = await db.query(brandsTable,
      where: '\$brandsColumnBrandId = ?',
      whereArgs: [brandId],);

    return maps.isEmpty
      ? null
      : Brands.fromMap(maps.first);
  }

  Future<bool> delete(int brandId) async {
    final result = await db.delete(brandsTable,
      where: '\$brandsColumnBrandId = ?',
      whereArgs: [brandId],);
      
    return result > 0;  
  }

  Future<bool> update(Brands brands) async {
    final result = await db.update(brandsTable, brands.toMap(),
      where: '\$brandsColumnBrandId = ?',
      whereArgs: [brands.brandId],);
      
    return result > 0;  
  }

}
