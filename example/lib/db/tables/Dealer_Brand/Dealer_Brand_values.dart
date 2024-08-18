const String Dealer_BrandTableName = 'Dealer_Brand';
const String Dealer_BrandColumnDealerId = 'dealer_id';
const String Dealer_BrandColumnBrandId = 'brand_id';

const String Dealer_BrandCreate = '''
CREATE TABLE $Dealer_BrandTableName (
 $Dealer_BrandColumnDealerId INTEGER NOT NULL,
 $Dealer_BrandColumnBrandId INTEGER NOT NULL,
)
''';
  