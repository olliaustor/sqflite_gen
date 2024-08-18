const String CustomersTableName = 'Customers';
const String CustomersColumnCustomerId = 'customer_id';
const String CustomersColumnFirstName = 'first_name';
const String CustomersColumnLastName = 'last_name';
const String CustomersColumnGender = 'gender';
const String CustomersColumnHouseholdIncome = 'household_income';
const String CustomersColumnBirthdate = 'birthdate';
const String CustomersColumnPhoneNumber = 'phone_number';
const String CustomersColumnEmail = 'email';

const String CustomersCreate = '''
CREATE TABLE $CustomersTableName (
 $CustomersColumnCustomerId INTEGER PRIMARY KEY AUTOINCREMENT,
 $CustomersColumnFirstName VARCHAR(50) NOT NULL,
 $CustomersColumnLastName VARCHAR(50) NOT NULL,
 $CustomersColumnGender STRING CHECK( = "MALE" OR  = "FEMALE"),
 $CustomersColumnHouseholdIncome INTEGER,
 $CustomersColumnBirthdate DATE NOT NULL,
 $CustomersColumnPhoneNumber INTEGER NOT NULL,
 $CustomersColumnEmail VARCHAR(128),
)
''';
  