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
Create Table Customers(
  customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  gender STRING CHECK(gender = "Male" or gender = "Female"),
  household_income INTEGER,
  birthdate DATE NOT NULL,
  phone_number INTEGER NOT NULL,
  email VARCHAR(128),
  is_active BOOL NOT NULL,
  nullable_is_active BOOL
);
''';
