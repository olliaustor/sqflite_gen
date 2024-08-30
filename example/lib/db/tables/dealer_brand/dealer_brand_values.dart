const String dealerBrandTable = 'Dealer_Brand';
const String dealerBrandColumnDealerId = 'dealer_id';
const String dealerBrandColumnBrandId = 'brand_id';

const String dealerBrandTableCreate = '''
Create Table Dealer_Brand(
  dealer_id INTEGER NOT NULL,
  brand_id INTEGER NOT NULL,
  FOREIGN KEY (dealer_id) REFERENCES Dealers(dealer_id),
  FOREIGN KEY (brand_id) REFERENCES Brands(brand_id),
  PRIMARY KEY (dealer_id, brand_id)
);
''';
