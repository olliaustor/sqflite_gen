const String Car_PartsTableName = 'Car_Parts';
const String Car_PartsColumnPartId = 'part_id';
const String Car_PartsColumnPartName = 'part_name';
const String Car_PartsColumnManufacturePlantId = 'manufacture_plant_id';
const String Car_PartsColumnManufactureStartDate = 'manufacture_start_date';
const String Car_PartsColumnManufactureEndDate = 'manufacture_end_date';
const String Car_PartsColumnPartRecall = 'part_recall';

const String Car_PartsCreate = '''
CREATE TABLE $Car_PartsTableName (
 $Car_PartsColumnPartId INTEGER PRIMARY KEY AUTOINCREMENT,
 $Car_PartsColumnPartName VARCHAR(100) NOT NULL,
 $Car_PartsColumnManufacturePlantId INTEGER NOT NULL,
 $Car_PartsColumnManufactureStartDate DATE NOT NULL,
 $Car_PartsColumnManufactureEndDate DATE,
 $Car_PartsColumnPartRecall INTEGER DEFAULT 0 CHECK ( = 0 OR  = 1),
)
''';
  