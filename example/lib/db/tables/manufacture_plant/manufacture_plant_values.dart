const String manufacturePlantTable = 'Manufacture_Plant';
const String manufacturePlantColumnManufacturePlantId = 'manufacture_plant_id';
const String manufacturePlantColumnPlantName = 'plant_name';
const String manufacturePlantColumnPlantType = 'plant_type';
const String manufacturePlantColumnPlantLocation = 'plant_location';
const String manufacturePlantColumnCompanyOwned = 'company_owned';

const String manufacturePlantTableCreate = '''
Create Table Manufacture_Plant(
  manufacture_plant_id INTEGER PRIMARY KEY AUTOINCREMENT,
  plant_name VARCHAR(50) NOT NULL,
  plant_type VARCHAR (7) CHECK (plant_type="Assembly" or plant_type="Parts"),
  plant_location VARCHAR(100),
  company_owned INTEGER CHECK(company_owned=0 or company_owned=1)
);
''';
