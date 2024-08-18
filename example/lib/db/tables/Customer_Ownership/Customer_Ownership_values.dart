const String Customer_OwnershipTableName = 'Customer_Ownership';
const String Customer_OwnershipColumnCustomerId = 'customer_id';
const String Customer_OwnershipColumnVin = 'vin';
const String Customer_OwnershipColumnPurchaseDate = 'purchase_date';
const String Customer_OwnershipColumnPurchasePrice = 'purchase_price';
const String Customer_OwnershipColumnWaranteeExpireDate = 'warantee_expire_date';
const String Customer_OwnershipColumnDealerId = 'dealer_id';

const String Customer_OwnershipCreate = '''
CREATE TABLE $Customer_OwnershipTableName (
 $Customer_OwnershipColumnCustomerId INTEGER NOT NULL,
 $Customer_OwnershipColumnVin INTEGER NOT NULL,
 $Customer_OwnershipColumnPurchaseDate DATE NOT NULL,
 $Customer_OwnershipColumnPurchasePrice INTEGER NOT NULL,
 $Customer_OwnershipColumnWaranteeExpireDate DATE,
 $Customer_OwnershipColumnDealerId INTEGER NOT NULL,
)
''';
  