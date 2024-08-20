const String modelsTable = 'Models';
const String modelsColumnModelId = 'model_id';
const String modelsColumnModelName = 'model_name';
const String modelsColumnModelBasePrice = 'model_base_price';
const String modelsColumnBrandId = 'brand_id';

const String modelsTableCreate = '''
CREATE TABLE $modelsTable (
 $modelsColumnModelId INTEGER PRIMARY KEY AUTOINCREMENT,
 $modelsColumnModelName VARCHAR(50) NOT NULL,
 $modelsColumnModelBasePrice INTEGER NOT NULL,
 $modelsColumnBrandId INTEGER NOT NULL,
)
''';
  