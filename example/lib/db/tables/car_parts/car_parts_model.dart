import 'car_parts_values.dart';

class CarParts {
  CarParts({
    this.partId,
    required this.partName,
    required this.manufacturePlantId,
    required this.manufactureStartDate,
    this.manufactureEndDate,
    this.partRecall,
  });
  
  final int? partId;
  final String partName;
  final int manufacturePlantId;
  final DateTime manufactureStartDate;
  final DateTime? manufactureEndDate;
  final int? partRecall;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      carPartsColumnPartName: partName,
      carPartsColumnManufacturePlantId: manufacturePlantId,
      carPartsColumnManufactureStartDate: manufactureStartDate.toUtc().millisecondsSinceEpoch,
      carPartsColumnManufactureEndDate: manufactureEndDate?.toUtc().millisecondsSinceEpoch,
      carPartsColumnPartRecall: partRecall,
    };
  
    if (partId != null) {
      map[carPartsColumnPartId] = partId;
    }
        
    return map;
  }  

  factory CarParts.fromMap(Map<String, Object?> map) {
    final partId = map[carPartsColumnPartId] as int?;
    final partName = map[carPartsColumnPartName] as String;
    final manufacturePlantId = map[carPartsColumnManufacturePlantId] as int;
    final manufactureStartDate = DateTime.fromMillisecondsSinceEpoch(map[carPartsColumnManufactureStartDate]! as int, isUtc: true,);
    final manufactureEndDate = map[carPartsColumnManufactureEndDate] == null ? null : (DateTime.fromMillisecondsSinceEpoch(map[carPartsColumnManufactureEndDate]! as int, isUtc: true,));
    final partRecall = map[carPartsColumnPartRecall] as int?;

    return CarParts(
      partId: partId, 
      partName: partName, 
      manufacturePlantId: manufacturePlantId, 
      manufactureStartDate: manufactureStartDate, 
      manufactureEndDate: manufactureEndDate, 
      partRecall: partRecall,
    );
  }  

}
