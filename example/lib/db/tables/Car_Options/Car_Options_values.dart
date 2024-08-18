const String Car_OptionsTableName = 'Car_Options';
const String Car_OptionsColumnOptionSetId = 'option_set_id';
const String Car_OptionsColumnModelId = 'model_id';
const String Car_OptionsColumnEngineId = 'engine_id';
const String Car_OptionsColumnTransmissionId = 'transmission_id';
const String Car_OptionsColumnChassisId = 'chassis_id';
const String Car_OptionsColumnPremiumSoundId = 'premium_sound_id';
const String Car_OptionsColumnColor = 'color';
const String Car_OptionsColumnOptionSetPrice = 'option_set_price';

const String Car_OptionsCreate = '''
CREATE TABLE $Car_OptionsTableName (
 $Car_OptionsColumnOptionSetId INTEGER PRIMARY KEY AUTOINCREMENT,
 $Car_OptionsColumnModelId INTEGER NULL,
 $Car_OptionsColumnEngineId INTEGER NOT NULL,
 $Car_OptionsColumnTransmissionId INTEGER NOT NULL,
 $Car_OptionsColumnChassisId INTEGER NOT NULL,
 $Car_OptionsColumnPremiumSoundId INTEGER,
 $Car_OptionsColumnColor VARCHAR(30) NOT NULL,
 $Car_OptionsColumnOptionSetPrice INTEGER NOT NULL,
)
''';
  