import 'customer_ownership_values.dart';
import '../../utils.dart';

class CustomerOwnership {
  CustomerOwnership({
    required this.customerId,
    required this.vin,
    required this.purchaseDate,
    required this.purchasePrice,
    this.waranteeExpireDate,
    required this.dealerId,
  });
  
    final int customerId;
    final int vin;
    final DateTime purchaseDate;
    final int purchasePrice;
    final DateTime? waranteeExpireDate;
    final int dealerId;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      customerOwnershipColumnCustomerId: customerId,
      customerOwnershipColumnVin: vin,
      customerOwnershipColumnPurchaseDate: purchaseDate.toUtc().millisecondsSinceEpoch,
      customerOwnershipColumnPurchasePrice: purchasePrice,
      customerOwnershipColumnWaranteeExpireDate: isNull(waranteeExpireDate) ? null : waranteeExpireDate!.toUtc().millisecondsSinceEpoch,
      customerOwnershipColumnDealerId: dealerId,
    };
        
    return map;
  }  

  factory CustomerOwnership.fromMap(Map<String, Object?> map) {
    final customerId = map[customerOwnershipColumnCustomerId] as int;
    final vin = map[customerOwnershipColumnVin] as int;
    final purchaseDate = DateTime.fromMillisecondsSinceEpoch(map[customerOwnershipColumnPurchaseDate] as int, isUtc: true,);
    final purchasePrice = map[customerOwnershipColumnPurchasePrice] as int;
    final waranteeExpireDate = isNull(map[customerOwnershipColumnWaranteeExpireDate]) ? null : DateTime.fromMillisecondsSinceEpoch(map[customerOwnershipColumnWaranteeExpireDate] as int, isUtc: true,);
    final dealerId = map[customerOwnershipColumnDealerId] as int;

    return CustomerOwnership(
      customerId: customerId,
      vin: vin,
      purchaseDate: purchaseDate,
      purchasePrice: purchasePrice,
      waranteeExpireDate: waranteeExpireDate,
      dealerId: dealerId,
    );
  }  

  CustomerOwnership copyWith({
    int? customerId,
    int? vin,
    DateTime? purchaseDate,
    int? purchasePrice,
    Wrapped<DateTime?>? waranteeExpireDate,
    int? dealerId,
  }) {
    return CustomerOwnership(
      customerId: isNull(customerId) ? this.customerId : customerId!,
      vin: isNull(vin) ? this.vin : vin!,
      purchaseDate: isNull(purchaseDate) ? this.purchaseDate : purchaseDate!,
      purchasePrice: isNull(purchasePrice) ? this.purchasePrice : purchasePrice!,
      waranteeExpireDate: isNull(waranteeExpireDate) ? this.waranteeExpireDate : (waranteeExpireDate!.value),
      dealerId: isNull(dealerId) ? this.dealerId : dealerId!,
    );
  }

}
