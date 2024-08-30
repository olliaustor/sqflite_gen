const String carPartsTable = 'Car_Parts';
const String carPartsColumnPartId = 'part_id';
const String carPartsColumnPartName = 'part_name';
const String carPartsColumnManufacturePlantId = 'manufacture_plant_id';
const String carPartsColumnManufactureStartDate = 'manufacture_start_date';
const String carPartsColumnManufactureEndDate = 'manufacture_end_date';
const String carPartsColumnPartRecall = 'part_recall';

const String carPartsTableCreate = '''
Create Table Car_Parts(
  part_id INTEGER PRIMARY KEY AUTOINCREMENT,
  part_name VARCHAR(100) NOT NULL,
  manufacture_plant_id INTEGER NOT NULL,
  manufacture_start_date DATE NOT NUll,
  manufacture_end_date DATE,
  part_recall INTEGER DEFAULT 0 CHECK (part_recall = 0 or part_recall = 1),
  FOREIGN KEY (manufacture_plant_id) REFERENCES Manufacture_Plant(manufacture_plant_id)
);
''';
