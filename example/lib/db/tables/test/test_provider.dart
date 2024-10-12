import '../../utils.dart';  
import 'test_model.dart';
import 'test_values.dart';
import 'package:sqflite/sqflite.dart';

class TestProvider {
  TestProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [testTableCreate];
  }

  Future<Test> insert(Test test) async {
    final result = await db.insert(testTable, test.toMap());
    
    return test.copyWith(id: Wrapped.value(result));
  }

  Future<Test?> get(int id) async {
    final maps = await db.query(testTable,
      where: '\$testColumnId = ?',
      whereArgs: [id],);

    return maps.isEmpty
      ? null
      : Test.fromMap(maps.first);
  }

  Future<List<Test>> getAll() async {
    final maps = await db.query(testTable);

    return maps.isEmpty
      ? []
      : maps.map((element) => Test.fromMap(element)).toList();
  }

  Future<bool> delete(int id) async {
    final result = await db.delete(testTable,
      where: '\$testColumnId = ?',
      whereArgs: [id],);
      
    return result > 0;  
  }

  Future<bool> update(Test test) async {
    final result = await db.update(testTable, test.toMap(),
      where: '\$testColumnId = ?',
      whereArgs: [test.id],);
      
    return result > 0;  
  }

}
