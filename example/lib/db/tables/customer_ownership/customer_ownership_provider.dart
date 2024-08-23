import '../../generic_provider.dart';
import 'customer_ownership_model.dart';
import 'customer_ownership_values.dart';
import 'package:sqflite/sqflite.dart';

class CustomerOwnershipProvider implements GenericProvider<CustomerOwnership> {
  CustomerOwnershipProvider(this.db);

  Database db;

  @override
  List<String> create(int version) {
    return [customerOwnershipTableCreate];
  }

  @override
  Future<CustomerOwnership> insert(CustomerOwnership customerOwnership) async {
    final result = await db.insert(customerOwnershipTable, customerOwnership.toMap());
       
    return customerOwnership.copyWith(unknown: result);
  }

  @override
  Future<CustomerOwnership?> get(int unknown) async {
    final maps = await db.query(customerOwnershipTable,
      where: '$unknown = ?',
      whereArgs: [unknown],);

    if (maps.isNotEmpty) {
      return CustomerOwnership.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int unknown) async {
    return db.delete(customerOwnershipTable,
      where: '$unknown = ?',
      whereArgs: [unknown],);
  }

  @override
  Future<int> update(CustomerOwnership customerOwnership) async {
    return db.update(customerOwnershipTable, customerOwnership.toMap(),
      where: '$unknown = ?',
      whereArgs: [customerOwnership.unknown],);
  }
}
