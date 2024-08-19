const String customerOwnershipTableName = 'Customer_Ownership';
const String customerOwnershipColumnCustomerId = 'customer_id';
const String customerOwnershipColumnVin = 'vin';
const String customerOwnershipColumnPurchaseDate = 'purchase_date';
const String customerOwnershipColumnPurchasePrice = 'purchase_price';
const String customerOwnershipColumnWaranteeExpireDate = 'warantee_expire_date';
const String customerOwnershipColumnDealerId = 'dealer_id';

const String customerOwnershipCreate = '''
CREATE TABLE $customerOwnershipTableName (
 $customerOwnershipColumnCustomerId INTEGER NOT NULL,
 $customerOwnershipColumnVin INTEGER NOT NULL,
 $customerOwnershipColumnPurchaseDate DATE NOT NULL,
 $customerOwnershipColumnPurchasePrice INTEGER NOT NULL,
 $customerOwnershipColumnWaranteeExpireDate DATE,
 $customerOwnershipColumnDealerId INTEGER NOT NULL,
)
''';
  