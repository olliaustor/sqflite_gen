const String carVinsTable = 'Car_Vins';
const String carVinsColumnVin = 'vin';
const String carVinsColumnModelId = 'model_id';
const String carVinsColumnOptionSetId = 'option_set_id';
const String carVinsColumnManufacturedDate = 'manufactured_date';
const String carVinsColumnManufacturedPlantId = 'manufactured_plant_id';

const String carVinsTableCreate = '''
Create Table Car_Vins(
  vin INTEGER PRIMARY KEY AUTOINCREMENT,
  model_id INTEGER NOT NULL,
  option_set_id INTEGER NOT NULL,
  manufactured_date DATE NOT NULL,
  manufactured_plant_id INTEGER NOT NULL,
  FOREIGN KEY (model_id) REFERENCES Models(model_id),
  FOREIGN KEY (manufactured_plant_id) REFERENCES Manufacture_Plant(manufacture_plant_id),
  FOREIGN KEY (option_set_id) REFERENCES Car_Options(option_set_id)
);
''';
