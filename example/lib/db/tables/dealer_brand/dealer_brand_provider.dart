import '../../utils.dart';  
import 'dealer_brand_model.dart';
import 'dealer_brand_values.dart';
import 'package:sqflite/sqflite.dart';

class DealerBrandProvider {
  DealerBrandProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [dealerBrandTableCreate];
  }

  Future<DealerBrand> insert(DealerBrand dealerBrand) async {
    final result = await db.insert(dealerBrandTable, dealerBrand.toMap());
    
    return dealerBrand;
  }




}
