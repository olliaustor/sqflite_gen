import 'car_vins_values.dart';

class CarVins {
  CarVins({
    this.vin,
    required this.modelId,
    required this.optionSetId,
    required this.manufacturedDate,
    required this.manufacturedPlantId,
  });
  
  final int? vin;
  final int modelId;
  final int optionSetId;
  final DateTime manufacturedDate;
  final int manufacturedPlantId;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      carVinsColumnModelId: modelId,
      carVinsColumnOptionSetId: optionSetId,
      carVinsColumnManufacturedDate: manufacturedDate.toUtc().millisecondsSinceEpoch,
      carVinsColumnManufacturedPlantId: manufacturedPlantId,
    };
  
    if (vin != null) {
      map[carVinsColumnVin] = vin;
    }
        
    return map;
  }  

  factory CarVins.fromMap(Map<String, Object?> map) {
    final vin = map[carVinsColumnVin] as int?;
    final modelId = map[carVinsColumnModelId] as int;
    final optionSetId = map[carVinsColumnOptionSetId] as int;
    final manufacturedDate = DateTime.fromMillisecondsSinceEpoch(map[carVinsColumnManufacturedDate]! as int, isUtc: true,);
    final manufacturedPlantId = map[carVinsColumnManufacturedPlantId] as int;

    return CarVins(
      vin: vin, 
      modelId: modelId, 
      optionSetId: optionSetId, 
      manufacturedDate: manufacturedDate, 
      manufacturedPlantId: manufacturedPlantId,
    );
  }  

}
