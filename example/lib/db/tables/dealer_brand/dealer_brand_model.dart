import 'dealer_brand_values.dart';
import '../../utils.dart';

class DealerBrand {
  DealerBrand({
    required this.dealerId,
    required this.brandId,
  });
  
    final int dealerId;
    final int brandId;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      dealerBrandColumnDealerId: dealerId,
      dealerBrandColumnBrandId: brandId,
    };
        
    return map;
  }  

  factory DealerBrand.fromMap(Map<String, Object?> map) {
    final dealerId = map[dealerBrandColumnDealerId] as int;
    final brandId = map[dealerBrandColumnBrandId] as int;

    return DealerBrand(
      dealerId: dealerId,
      brandId: brandId,
    );
  }  

  DealerBrand copyWith({
    int? dealerId,
    int? brandId,
  }) {
    return DealerBrand(
      dealerId: isNull(dealerId) ? this.dealerId : dealerId!,
      brandId: isNull(brandId) ? this.brandId : brandId!,
    );
  }

}
