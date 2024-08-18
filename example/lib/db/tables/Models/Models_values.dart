const String ModelsTableName = 'Models';
const String ModelsColumnModelId = 'model_id';
const String ModelsColumnModelName = 'model_name';
const String ModelsColumnModelBasePrice = 'model_base_price';
const String ModelsColumnBrandId = 'brand_id';

const String ModelsCreate = '''
CREATE TABLE $ModelsTableName (
 $ModelsColumnModelId INTEGER PRIMARY KEY AUTOINCREMENT,
 $ModelsColumnModelName VARCHAR(50) NOT NULL,
 $ModelsColumnModelBasePrice INTEGER NOT NULL,
 $ModelsColumnBrandId INTEGER NOT NULL,
)
''';
  