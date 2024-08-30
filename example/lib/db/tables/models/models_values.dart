const String modelsTable = 'Models';
const String modelsColumnModelId = 'model_id';
const String modelsColumnModelName = 'model_name';
const String modelsColumnModelBasePrice = 'model_base_price';
const String modelsColumnBrandId = 'brand_id';

const String modelsTableCreate = '''
Create Table Models(
  model_id INTEGER PRIMARY KEY AUTOINCREMENT,
  model_name VARCHAR(50) NOT NULL,
  model_base_price INTEGER NOT NULL,
  brand_id INTEGER NOT NULL,
  FOREIGN KEY (brand_id) REFERENCES Brands(brand_id)
);
''';
