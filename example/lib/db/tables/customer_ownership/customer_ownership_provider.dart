import '../../generic_provider.dart';
import 'customer_ownership_model.dart';
import 'customer_ownership_values.dart';
import 'package:sqflite/sqflite.dart';

class CustomerOwnershipProvider {
  CustomerOwnershipProvider(this.db);

  final Database db;

  List<String> create(int version) {
    return [customerOwnershipTableCreate];
  }

  Future<CustomerOwnership> insert(CustomerOwnership customerOwnership) async {
    final result = await db.insert(customerOwnershipTable, customerOwnership.toMap());
    
    return customerOwnership;
  }




