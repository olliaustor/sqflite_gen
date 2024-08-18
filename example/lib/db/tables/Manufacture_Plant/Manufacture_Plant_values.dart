const String Manufacture_PlantTableName = 'Manufacture_Plant';
const String Manufacture_PlantColumnManufacturePlantId = 'manufacture_plant_id';
const String Manufacture_PlantColumnPlantName = 'plant_name';
const String Manufacture_PlantColumnPlantType = 'plant_type';
const String Manufacture_PlantColumnPlantLocation = 'plant_location';
const String Manufacture_PlantColumnCompanyOwned = 'company_owned';

const String Manufacture_PlantCreate = '''
CREATE TABLE $Manufacture_PlantTableName (
 $Manufacture_PlantColumnManufacturePlantId INTEGER PRIMARY KEY AUTOINCREMENT,
 $Manufacture_PlantColumnPlantName VARCHAR(50) NOT NULL,
 $Manufacture_PlantColumnPlantType VARCHAR (7) CHECK (="ASSEMBLY" OR ="PARTS"),
 $Manufacture_PlantColumnPlantLocation VARCHAR(100),
 $Manufacture_PlantColumnCompanyOwned INTEGER CHECK(=0 OR =1),
)
''';
  