const String manufacturePlantTableName = 'Manufacture_Plant';
const String manufacturePlantColumnManufacturePlantId = 'manufacture_plant_id';
const String manufacturePlantColumnPlantName = 'plant_name';
const String manufacturePlantColumnPlantType = 'plant_type';
const String manufacturePlantColumnPlantLocation = 'plant_location';
const String manufacturePlantColumnCompanyOwned = 'company_owned';

const String manufacturePlantCreate = '''
CREATE TABLE $manufacturePlantTableName (
 $manufacturePlantColumnManufacturePlantId INTEGER PRIMARY KEY AUTOINCREMENT,
 $manufacturePlantColumnPlantName VARCHAR(50) NOT NULL,
 $manufacturePlantColumnPlantType VARCHAR (7) CHECK (="ASSEMBLY" OR ="PARTS"),
 $manufacturePlantColumnPlantLocation VARCHAR(100),
 $manufacturePlantColumnCompanyOwned INTEGER CHECK(=0 OR =1),
)
''';
  