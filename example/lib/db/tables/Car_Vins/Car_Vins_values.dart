const String Car_VinsTableName = 'Car_Vins';
const String Car_VinsColumnVin = 'vin';
const String Car_VinsColumnModelId = 'model_id';
const String Car_VinsColumnOptionSetId = 'option_set_id';
const String Car_VinsColumnManufacturedDate = 'manufactured_date';
const String Car_VinsColumnManufacturedPlantId = 'manufactured_plant_id';

const String Car_VinsCreate = '''
CREATE TABLE $Car_VinsTableName (
 $Car_VinsColumnVin INTEGER PRIMARY KEY AUTOINCREMENT,
 $Car_VinsColumnModelId INTEGER NOT NULL,
 $Car_VinsColumnOptionSetId INTEGER NOT NULL,
 $Car_VinsColumnManufacturedDate DATE NOT NULL,
 $Car_VinsColumnManufacturedPlantId INTEGER NOT NULL,
)
''';
  