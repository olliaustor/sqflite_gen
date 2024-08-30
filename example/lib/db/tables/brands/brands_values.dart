const String brandsTable = 'Brands';
const String brandsColumnBrandId = 'brand_id';
const String brandsColumnBrandName = 'brand_name';

const String brandsTableCreate = '''
Create Table Brands(
  brand_id INTEGER PRIMARY KEY AUTOINCREMENT,
  brand_name VARCHAR(50) NOT NUll
);
''';
