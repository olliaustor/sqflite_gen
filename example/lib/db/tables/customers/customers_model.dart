import 'customers_values.dart';

class Customers {
  Customers({
    this.customerId,
    required this.firstName,
    required this.lastName,
    this.gender,
    this.householdIncome,
    required this.birthdate,
    required this.phoneNumber,
    this.email,
    required this.isActive,
    this.nullableIsActive,
  });
  
  final int? customerId;
  final String firstName;
  final String lastName;
  final String? gender;
  final int? householdIncome;
  final DateTime birthdate;
  final int phoneNumber;
  final String? email;
  final bool isActive;
  final bool? nullableIsActive;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      customersColumnFirstName: firstName,
      customersColumnLastName: lastName,
      customersColumnGender: gender,
      customersColumnHouseholdIncome: householdIncome,
      customersColumnBirthdate: birthdate.toUtc().millisecondsSinceEpoch,
      customersColumnPhoneNumber: phoneNumber,
      customersColumnEmail: email,
      customersColumnIsActive: isActive ? 1 : 0,
      customersColumnNullableIsActive: nullableIsActive == null ? null : (nullableIsActive! ? 1 : 0),
    };
  
    if (customerId != null) {
      map[customersColumnCustomerId] = customerId;
    }
        
    return map;
  }  

  factory Customers.fromMap(Map<String, Object?> map) {
    final customerId = map[customersColumnCustomerId] as int?;
    final firstName = map[customersColumnFirstName] as String;
    final lastName = map[customersColumnLastName] as String;
    final gender = map[customersColumnGender] as String?;
    final householdIncome = map[customersColumnHouseholdIncome] as int?;
    final birthdate = DateTime.fromMillisecondsSinceEpoch(map[customersColumnBirthdate]! as int, isUtc: true,);
    final phoneNumber = map[customersColumnPhoneNumber] as int;
    final email = map[customersColumnEmail] as String?;
    final isActive = map[customersColumnIsActive] == 1;
    final nullableIsActive = map[customersColumnNullableIsActive] == null ? null : (map[customersColumnNullableIsActive] == 1);

    return Customers(
      customerId: customerId, 
      firstName: firstName, 
      lastName: lastName, 
      gender: gender, 
      householdIncome: householdIncome, 
      birthdate: birthdate, 
      phoneNumber: phoneNumber, 
      email: email, 
      isActive: isActive, 
      nullableIsActive: nullableIsActive,
    );
  }  

}
