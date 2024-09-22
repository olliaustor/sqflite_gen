import '../../generic_provider.dart';
import 'customers_model.dart';
import 'customers_values.dart';
import 'package:sqflite/sqflite.dart';

class CustomersProvider {
  CustomersProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [customersTableCreate];
  }

  Future<Customers> insert(Customers customers) async {
    final result = await db.insert(customersTable, customers.toMap());
    
    return customers.copyWith(customerId: result);
  }

  Future<Customers?> get(int customerId) async {
    final maps = await db.query(customersTable,
      where: '\$customersColumnCustomerId = ?',
      whereArgs: [customerId],);

    return maps.isEmpty
      ? null
      : Customers.fromMap(maps.first);
  }

  Future<bool> delete(int customerId) async {
    final result = db.delete(customersTable,
      where: '\$customersColumnCustomerId = ?',
      whereArgs: [customerId],);
      
    return result > 0;  
  }

  Future<bool> update(Customers customers) async {
    final result = db.update(customersTable, customers.toMap(),
      where: '\$customersColumnCustomerId = ?',
      whereArgs: [customers.customerId],);
      
    return result > 0;  
  }

