import 'customers_values.dart';
import '../../utils.dart';

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
      customersColumnIsActive: boolToInt(isActive),
      customersColumnNullableIsActive: isNull(nullableIsActive) ? null : boolToInt(nullableIsActive!),
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
    final birthdate = DateTime.fromMillisecondsSinceEpoch(map[customersColumnBirthdate] as int, isUtc: true,);
    final phoneNumber = map[customersColumnPhoneNumber] as int;
    final email = map[customersColumnEmail] as String?;
    final isActive = intToBool(map[customersColumnIsActive] as int);
    final nullableIsActive = isNull(map[customersColumnNullableIsActive]) ? null : intToBool(map[customersColumnNullableIsActive] as int);

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

  Customers copyWith({
    Wrapped<int?>? customerId,
    String? firstName,
    String? lastName,
    Wrapped<String?>? gender,
    Wrapped<int?>? householdIncome,
    DateTime? birthdate,
    int? phoneNumber,
    Wrapped<String?>? email,
    bool? isActive,
    Wrapped<bool?>? nullableIsActive,
  }) {
    return Customers(
      customerId: isNull(customerId) ? this.customerId : (customerId!.value),
      firstName: isNull(firstName) ? this.firstName : firstName!,
      lastName: isNull(lastName) ? this.lastName : lastName!,
      gender: isNull(gender) ? this.gender : (gender!.value),
      householdIncome: isNull(householdIncome) ? this.householdIncome : (householdIncome!.value),
      birthdate: isNull(birthdate) ? this.birthdate : birthdate!,
      phoneNumber: isNull(phoneNumber) ? this.phoneNumber : phoneNumber!,
      email: isNull(email) ? this.email : (email!.value),
      isActive: isNull(isActive) ? this.isActive : isActive!,
      nullableIsActive: isNull(nullableIsActive) ? this.nullableIsActive : (nullableIsActive!.value),
    );
  }

}
