import '../../generic_provider.dart';
import 'models_model.dart';
import 'models_values.dart';
import 'package:sqflite/sqflite.dart';

class ModelsProvider implements GenericProvider<Models> {
  ModelsProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [modelsTableCreate];
  }

  @override
  Future<Models> insert(Models models) async {
    final result = await db.insert(modelsTable, models.toMap());
       
    return models.copyWith(modelId: result);
  }

  @override
  Future<Models?> get(int modelId) async {
    final maps = await db.query(modelsTable,
      where: '$modelsColumnModelId = ?',
      whereArgs: [modelId],);

    if (maps.isNotEmpty) {
      return Models.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int modelId) async {
    return db.delete(modelsTable,
      where: '$modelsColumnModelId = ?',
      whereArgs: [modelId],);
  }

  @override
  Future<int> update(Models models) async {
    return db.update(modelsTable, models.toMap(),
      where: '$modelsColumnModelId = ?',
      whereArgs: [models.modelId],);
  }
}
