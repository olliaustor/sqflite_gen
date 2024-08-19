const String carPartsTableName = 'Car_Parts';
const String carPartsColumnPartId = 'part_id';
const String carPartsColumnPartName = 'part_name';
const String carPartsColumnManufacturePlantId = 'manufacture_plant_id';
const String carPartsColumnManufactureStartDate = 'manufacture_start_date';
const String carPartsColumnManufactureEndDate = 'manufacture_end_date';
const String carPartsColumnPartRecall = 'part_recall';

const String carPartsCreate = '''
CREATE TABLE $carPartsTableName (
 $carPartsColumnPartId INTEGER PRIMARY KEY AUTOINCREMENT,
 $carPartsColumnPartName VARCHAR(100) NOT NULL,
 $carPartsColumnManufacturePlantId INTEGER NOT NULL,
 $carPartsColumnManufactureStartDate DATE NOT NULL,
 $carPartsColumnManufactureEndDate DATE,
 $carPartsColumnPartRecall INTEGER DEFAULT 0 CHECK ( = 0 OR  = 1),
)
''';
  