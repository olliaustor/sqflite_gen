import '../../generic_provider.dart';
import 'customers_model.dart';
import 'customers_values.dart';
import 'package:sqflite/sqflite.dart';

class CustomersProvider implements GenericProvider<Customers> {
  CustomersProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [customersTableCreate];
  }

  @override
  Future<Customers> insert(Customers customers) async {
    final result = await db.insert(customersTable, customers.toMap());
       
    return customers.copyWith(customerId: result);
  }

  @override
  Future<Customers?> get(int customerId) async {
    final maps = await db.query(customersTable,
      where: '$customersColumnCustomerId = ?',
      whereArgs: [customerId],);

    if (maps.isNotEmpty) {
      return Customers.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int customerId) async {
    return db.delete(customersTable,
      where: '$customersColumnCustomerId = ?',
      whereArgs: [customerId],);
  }

  @override
  Future<int> update(Customers customers) async {
    return db.update(customersTable, customers.toMap(),
      where: '$customersColumnCustomerId = ?',
      whereArgs: [customers.customerId],);
  }
}
