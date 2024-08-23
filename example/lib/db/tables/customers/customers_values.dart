const String customersTable = 'Customers';
const String customersColumnCustomerId = 'customer_id';
const String customersColumnFirstName = 'first_name';
const String customersColumnLastName = 'last_name';
const String customersColumnGender = 'gender';
const String customersColumnHouseholdIncome = 'household_income';
const String customersColumnBirthdate = 'birthdate';
const String customersColumnPhoneNumber = 'phone_number';
const String customersColumnEmail = 'email';
const String customersColumnIsActive = 'is_active';
const String customersColumnNullableIsActive = 'nullable_is_active';

const String customersTableCreate = '''
CREATE TABLE $customersTable (
 $customersColumnCustomerId INTEGER PRIMARY KEY AUTOINCREMENT,
 $customersColumnFirstName VARCHAR(50) NOT NULL,
 $customersColumnLastName VARCHAR(50) NOT NULL,
 $customersColumnGender STRING CHECK( = "MALE" OR  = "FEMALE"),
 $customersColumnHouseholdIncome INTEGER,
 $customersColumnBirthdate DATE NOT NULL,
 $customersColumnPhoneNumber INTEGER NOT NULL,
 $customersColumnEmail VARCHAR(128),
 $customersColumnIsActive BOOL NOT NULL,
 $customersColumnNullableIsActive BOOL,
)
''';
  