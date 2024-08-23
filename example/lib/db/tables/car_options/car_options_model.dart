import 'car_options_values.dart';
import '../../utils.dart';

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

  CarOptions copyWith({
       Wrapped<int?>? optionSetId,
       Wrapped<int?>? modelId,
       int? engineId,
       int? transmissionId,
       int? chassisId,
       Wrapped<int?>? premiumSoundId,
       String? color,
       int? optionSetPrice,
  }) {
    return CarOptions(
      optionSetId: isNull(optionSetId) ? this.optionSetId : (optionSetId!.value),
      modelId: isNull(modelId) ? this.modelId : (modelId!.value),
      engineId: isNull(engineId) ? this.engineId : engineId!,
      transmissionId: isNull(transmissionId) ? this.transmissionId : transmissionId!,
      chassisId: isNull(chassisId) ? this.chassisId : chassisId!,
      premiumSoundId: isNull(premiumSoundId) ? this.premiumSoundId : (premiumSoundId!.value),
      color: isNull(color) ? this.color : color!,
      optionSetPrice: isNull(optionSetPrice) ? this.optionSetPrice : optionSetPrice!,    
    );
  }  

}
