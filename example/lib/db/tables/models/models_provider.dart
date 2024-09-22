import '../../utils.dart';  
import 'models_model.dart';
import 'models_values.dart';
import 'package:sqflite/sqflite.dart';

class ModelsProvider {
  ModelsProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [modelsTableCreate];
  }

  Future<Models> insert(Models models) async {
    final result = await db.insert(modelsTable, models.toMap());
    
    return models.copyWith(modelId: Wrapped.value(result));
  }

  Future<Models?> get(int modelId) async {
    final maps = await db.query(modelsTable,
      where: '\$modelsColumnModelId = ?',
      whereArgs: [modelId],);

    return maps.isEmpty
      ? null
      : Models.fromMap(maps.first);
  }

  Future<bool> delete(int modelId) async {
    final result = await db.delete(modelsTable,
      where: '\$modelsColumnModelId = ?',
      whereArgs: [modelId],);
      
    return result > 0;  
  }

  Future<bool> update(Models models) async {
    final result = await db.update(modelsTable, models.toMap(),
      where: '\$modelsColumnModelId = ?',
      whereArgs: [models.modelId],);
      
    return result > 0;  
  }

}
