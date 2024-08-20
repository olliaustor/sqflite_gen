const String dealerBrandTable = 'Dealer_Brand';
const String dealerBrandColumnDealerId = 'dealer_id';
const String dealerBrandColumnBrandId = 'brand_id';

const String dealerBrandTableCreate = '''
CREATE TABLE $dealerBrandTable (
 $dealerBrandColumnDealerId INTEGER NOT NULL,
 $dealerBrandColumnBrandId INTEGER NOT NULL,
)
''';
  