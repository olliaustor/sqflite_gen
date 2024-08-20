const String brandsTable = 'Brands';
const String brandsColumnBrandId = 'brand_id';
const String brandsColumnBrandName = 'brand_name';

const String brandsTableCreate = '''
CREATE TABLE $brandsTable (
 $brandsColumnBrandId INTEGER PRIMARY KEY AUTOINCREMENT,
 $brandsColumnBrandName VARCHAR(50) NOT NULL,
)
''';
  