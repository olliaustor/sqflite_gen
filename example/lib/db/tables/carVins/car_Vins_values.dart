const String carVinsTableName = 'Car_Vins';
const String carVinsColumnVin = 'vin';
const String carVinsColumnModelId = 'model_id';
const String carVinsColumnOptionSetId = 'option_set_id';
const String carVinsColumnManufacturedDate = 'manufactured_date';
const String carVinsColumnManufacturedPlantId = 'manufactured_plant_id';

const String carVinsCreate = '''
CREATE TABLE $carVinsTableName (
 $carVinsColumnVin INTEGER PRIMARY KEY AUTOINCREMENT,
 $carVinsColumnModelId INTEGER NOT NULL,
 $carVinsColumnOptionSetId INTEGER NOT NULL,
 $carVinsColumnManufacturedDate DATE NOT NULL,
 $carVinsColumnManufacturedPlantId INTEGER NOT NULL,
)
''';
  