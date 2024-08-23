import 'customer_ownership_values.dart';

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
      customerOwnershipColumnWaranteeExpireDate: waranteeExpireDate?.toUtc().millisecondsSinceEpoch,
      customerOwnershipColumnDealerId: dealerId,
    };
        
    return map;
  }  

  factory CustomerOwnership.fromMap(Map<String, Object?> map) {
    final customerId = map[customerOwnershipColumnCustomerId] as int;
    final vin = map[customerOwnershipColumnVin] as int;
    final purchaseDate = DateTime.fromMillisecondsSinceEpoch(map[customerOwnershipColumnPurchaseDate]! as int, isUtc: true,);
    final purchasePrice = map[customerOwnershipColumnPurchasePrice] as int;
    final waranteeExpireDate = map[customerOwnershipColumnWaranteeExpireDate] == null ? null : (DateTime.fromMillisecondsSinceEpoch(map[customerOwnershipColumnWaranteeExpireDate]! as int, isUtc: true,));
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

}
