import 'car_options_values.dart';

class CarOptions {
  CarOptions({
    this.optionSetId,
    this.modelId,
    required this.engineId,
    required this.transmissionId,
    required this.chassisId,
    this.premiumSoundId,
    required this.color,
    required this.optionSetPrice,
  });
  
  final int? optionSetId;
  final int? modelId;
  final int engineId;
  final int transmissionId;
  final int chassisId;
  final int? premiumSoundId;
  final String color;
  final int optionSetPrice;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      carOptionsColumnModelId: modelId,
      carOptionsColumnEngineId: engineId,
      carOptionsColumnTransmissionId: transmissionId,
      carOptionsColumnChassisId: chassisId,
      carOptionsColumnPremiumSoundId: premiumSoundId,
      carOptionsColumnColor: color,
      carOptionsColumnOptionSetPrice: optionSetPrice,
    };
  
    if (optionSetId != null) {
      map[carOptionsColumnOptionSetId] = optionSetId;
    }
        
    return map;
  }  

  factory CarOptions.fromMap(Map<String, Object?> map) {
    final optionSetId = map[carOptionsColumnOptionSetId] as int?;
    final modelId = map[carOptionsColumnModelId] as int?;
    final engineId = map[carOptionsColumnEngineId] as int;
    final transmissionId = map[carOptionsColumnTransmissionId] as int;
    final chassisId = map[carOptionsColumnChassisId] as int;
    final premiumSoundId = map[carOptionsColumnPremiumSoundId] as int?;
    final color = map[carOptionsColumnColor] as String;
    final optionSetPrice = map[carOptionsColumnOptionSetPrice] as int;

    return CarOptions(
      optionSetId: optionSetId, 
      modelId: modelId, 
      engineId: engineId, 
      transmissionId: transmissionId, 
      chassisId: chassisId, 
      premiumSoundId: premiumSoundId, 
      color: color, 
      optionSetPrice: optionSetPrice,
    );
  }  

}
