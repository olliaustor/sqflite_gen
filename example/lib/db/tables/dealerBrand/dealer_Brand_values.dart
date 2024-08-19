const String dealerBrandTableName = 'Dealer_Brand';
const String dealerBrandColumnDealerId = 'dealer_id';
const String dealerBrandColumnBrandId = 'brand_id';

const String dealerBrandCreate = '''
CREATE TABLE $dealerBrandTableName (
 $dealerBrandColumnDealerId INTEGER NOT NULL,
 $dealerBrandColumnBrandId INTEGER NOT NULL,
)
''';
  