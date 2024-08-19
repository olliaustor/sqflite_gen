const String brandsTableName = 'Brands';
const String brandsColumnBrandId = 'brand_id';
const String brandsColumnBrandName = 'brand_name';

const String brandsCreate = '''
CREATE TABLE $brandsTableName (
 $brandsColumnBrandId INTEGER PRIMARY KEY AUTOINCREMENT,
 $brandsColumnBrandName VARCHAR(50) NOT NULL,
)
''';
  