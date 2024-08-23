import 'models_values.dart';
import '../../utils.dart';

class Models {
  Models({
    this.modelId,
    required this.modelName,
    required this.modelBasePrice,
    required this.brandId,
  });
  
  final int? modelId;
  final String modelName;
  final int modelBasePrice;
  final int brandId;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      modelsColumnModelName: modelName,
      modelsColumnModelBasePrice: modelBasePrice,
      modelsColumnBrandId: brandId,
    };
  
    if (modelId != null) {
      map[modelsColumnModelId] = modelId;
    }
        
    return map;
  }  

  factory Models.fromMap(Map<String, Object?> map) {
    final modelId = map[modelsColumnModelId] as int?;
    final modelName = map[modelsColumnModelName] as String;
    final modelBasePrice = map[modelsColumnModelBasePrice] as int;
    final brandId = map[modelsColumnBrandId] as int;

    return Models(
      modelId: modelId, 
      modelName: modelName, 
      modelBasePrice: modelBasePrice, 
      brandId: brandId,
    );
  }  

  Models copyWith({
       Wrapped<int?>? modelId,
       String? modelName,
       int? modelBasePrice,
       int? brandId,
  }) {
    return Models(
      modelId: isNull(modelId) ? this.modelId : (modelId!.value),
      modelName: isNull(modelName) ? this.modelName : modelName!,
      modelBasePrice: isNull(modelBasePrice) ? this.modelBasePrice : modelBasePrice!,
      brandId: isNull(brandId) ? this.brandId : brandId!,    
    );
  }  

}
