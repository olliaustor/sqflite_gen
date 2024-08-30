const String carOptionsTable = 'Car_Options';
const String carOptionsColumnOptionSetId = 'option_set_id';
const String carOptionsColumnModelId = 'model_id';
const String carOptionsColumnEngineId = 'engine_id';
const String carOptionsColumnTransmissionId = 'transmission_id';
const String carOptionsColumnChassisId = 'chassis_id';
const String carOptionsColumnPremiumSoundId = 'premium_sound_id';
const String carOptionsColumnColor = 'color';
const String carOptionsColumnOptionSetPrice = 'option_set_price';

const String carOptionsTableCreate = '''
Create Table Car_Options(
  option_set_id INTEGER PRIMARY KEY AUTOINCREMENT,
  model_id INTEGER NULL,
  engine_id INTEGER NOT NULL,
  transmission_id INTEGER NOT NULL,
  chassis_id INTEGER NOT NULL,
  premium_sound_id INTEGER,
  color VARCHAR(30) NOT NULL,
  option_set_price INTEGER NOT NUll,
  FOREIGN KEY (model_id) REFERENCES Models(model_id),
  FOREIGN KEY (engine_id) REFERENCES Car_Parts(part_id),
  FOREIGN KEY (premium_sound_id) REFERENCES Car_Parts(part_id),
  FOREIGN KEY (transmission_id) REFERENCES Car_Parts(part_id),
  FOREIGN KEY (chassis_id) REFERENCES Car_Parts(part_id)
);
''';
