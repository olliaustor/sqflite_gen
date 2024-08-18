const String BrandsTableName = 'Brands';
const String BrandsColumnBrandId = 'brand_id';
const String BrandsColumnBrandName = 'brand_name';

const String BrandsCreate = '''
CREATE TABLE $BrandsTableName (
 $BrandsColumnBrandId INTEGER PRIMARY KEY AUTOINCREMENT,
 $BrandsColumnBrandName VARCHAR(50) NOT NULL,
)
''';
  