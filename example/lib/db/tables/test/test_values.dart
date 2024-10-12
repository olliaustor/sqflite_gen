const String testTable = 'Test';
const String testColumnId = 'id';
const String testColumnText = 'text';
const String testColumnNumber = 'number';
const String testColumnNumeric = 'numeric';
const String testColumnDate = 'date';
const String testColumnIsChecked = 'is_checked';
const String testColumnAnything = 'anything';

const String testTableCreate = '''
Create Table Test(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  text VARCHAR NOT NULL,
  number INTEGER NOT NULL,
  numeric DOUBLE NOT NULL,
  date DATE NOT NULL,
  is_checked BOOL NOT NULL,
  anything BLOB NOT NULL
);
''';
