import 'car_parts_values.dart';
import '../../utils.dart';

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
      carPartsColumnManufactureEndDate: isNull(manufactureEndDate) ? null : manufactureEndDate!.toUtc().millisecondsSinceEpoch,
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
    final manufactureStartDate = DateTime.fromMillisecondsSinceEpoch(map[carPartsColumnManufactureStartDate] as int, isUtc: true,);
    final manufactureEndDate = isNull(map[carPartsColumnManufactureEndDate]) ? null : DateTime.fromMillisecondsSinceEpoch(map[carPartsColumnManufactureEndDate] as int, isUtc: true,);
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

  CarParts copyWith({
    Wrapped<int?>? partId,
    String? partName,
    int? manufacturePlantId,
    DateTime? manufactureStartDate,
    Wrapped<DateTime?>? manufactureEndDate,
    Wrapped<int?>? partRecall,
  }) {
    return CarParts(
      partId: isNull(partId) ? this.partId : (partId!.value),
      partName: isNull(partName) ? this.partName : partName!,
      manufacturePlantId: isNull(manufacturePlantId) ? this.manufacturePlantId : manufacturePlantId!,
      manufactureStartDate: isNull(manufactureStartDate) ? this.manufactureStartDate : manufactureStartDate!,
      manufactureEndDate: isNull(manufactureEndDate) ? this.manufactureEndDate : (manufactureEndDate!.value),
      partRecall: isNull(partRecall) ? this.partRecall : (partRecall!.value),
    );
  }

}
