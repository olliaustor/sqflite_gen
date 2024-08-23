import 'dealers_values.dart';

class Dealers {
  Dealers({
    this.dealerId,
    required this.dealerName,
    this.dealerAddress,
  });
  
  final int? dealerId;
  final String dealerName;
  final String? dealerAddress;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      dealersColumnDealerName: dealerName,
      dealersColumnDealerAddress: dealerAddress,
    };
  
    if (dealerId != null) {
      map[dealersColumnDealerId] = dealerId;
    }
        
    return map;
  }  

  factory Dealers.fromMap(Map<String, Object?> map) {
    final dealerId = map[dealersColumnDealerId] as int?;
    final dealerName = map[dealersColumnDealerName] as String;
    final dealerAddress = map[dealersColumnDealerAddress] as String?;

    return Dealers(
      dealerId: dealerId, 
      dealerName: dealerName, 
      dealerAddress: dealerAddress,
    );
  }  

}
