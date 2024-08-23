import 'brands_values.dart';

class Brands {
  Brands({
    this.brandId,
    required this.brandName,
  });
  
  final int? brandId;
  final String brandName;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      brandsColumnBrandName: brandName,
    };
  
    if (brandId != null) {
      map[brandsColumnBrandId] = brandId;
    }
        
    return map;
  }  

  factory Brands.fromMap(Map<String, Object?> map) {
    final brandId = map[brandsColumnBrandId] as int?;
    final brandName = map[brandsColumnBrandName] as String;

    return Brands(
      brandId: brandId, 
      brandName: brandName,
    );
  }  

}
