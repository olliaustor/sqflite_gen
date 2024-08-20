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
CREATE TABLE $carOptionsTable (
 $carOptionsColumnOptionSetId INTEGER PRIMARY KEY AUTOINCREMENT,
 $carOptionsColumnModelId INTEGER NULL,
 $carOptionsColumnEngineId INTEGER NOT NULL,
 $carOptionsColumnTransmissionId INTEGER NOT NULL,
 $carOptionsColumnChassisId INTEGER NOT NULL,
 $carOptionsColumnPremiumSoundId INTEGER,
 $carOptionsColumnColor VARCHAR(30) NOT NULL,
 $carOptionsColumnOptionSetPrice INTEGER NOT NULL,
)
''';
  