const String customerOwnershipTable = 'Customer_Ownership';
const String customerOwnershipColumnCustomerId = 'customer_id';
const String customerOwnershipColumnVin = 'vin';
const String customerOwnershipColumnPurchaseDate = 'purchase_date';
const String customerOwnershipColumnPurchasePrice = 'purchase_price';
const String customerOwnershipColumnWaranteeExpireDate = 'warantee_expire_date';
const String customerOwnershipColumnDealerId = 'dealer_id';

const String customerOwnershipTableCreate = '''
Create Table Customer_Ownership(
  customer_id INTEGER NOT NULL,
  vin INTEGER NOT NULL,
  purchase_date DATE NOT NULL,
  purchase_price INTEGER NOT NULL,
  warantee_expire_date DATE,
  dealer_id INTEGER NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (vin) REFERENCES Car_Vins(vin),
  FOREIGN KEY (dealer_id) REFERENCES Dealers(dealer_id),
  PRIMARY KEY (customer_id, vin)
);
''';
