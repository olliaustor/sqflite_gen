import 'manufacture_plant_values.dart';

class ManufacturePlant {
  ManufacturePlant({
    this.manufacturePlantId,
    required this.plantName,
    this.plantType,
    this.plantLocation,
    this.companyOwned,
  });
  
  final int? manufacturePlantId;
  final String plantName;
  final String? plantType;
  final String? plantLocation;
  final int? companyOwned;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      manufacturePlantColumnPlantName: plantName,
      manufacturePlantColumnPlantType: plantType,
      manufacturePlantColumnPlantLocation: plantLocation,
      manufacturePlantColumnCompanyOwned: companyOwned,
    };
  
    if (manufacturePlantId != null) {
      map[manufacturePlantColumnManufacturePlantId] = manufacturePlantId;
    }
        
    return map;
  }  

  factory ManufacturePlant.fromMap(Map<String, Object?> map) {
    final manufacturePlantId = map[manufacturePlantColumnManufacturePlantId] as int?;
    final plantName = map[manufacturePlantColumnPlantName] as String;
    final plantType = map[manufacturePlantColumnPlantType] as String?;
    final plantLocation = map[manufacturePlantColumnPlantLocation] as String?;
    final companyOwned = map[manufacturePlantColumnCompanyOwned] as int?;

    return ManufacturePlant(
      manufacturePlantId: manufacturePlantId, 
      plantName: plantName, 
      plantType: plantType, 
      plantLocation: plantLocation, 
      companyOwned: companyOwned,
    );
  }  

}
