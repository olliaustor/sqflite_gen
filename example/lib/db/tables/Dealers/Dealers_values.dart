const String DealersTableName = 'Dealers';
const String DealersColumnDealerId = 'dealer_id';
const String DealersColumnDealerName = 'dealer_name';
const String DealersColumnDealerAddress = 'dealer_address';

const String DealersCreate = '''
CREATE TABLE $DealersTableName (
 $DealersColumnDealerId INTEGER PRIMARY KEY AUTOINCREMENT,
 $DealersColumnDealerName VARCHAR(50) NOT NULL,
 $DealersColumnDealerAddress VARCHAR(100),
)
''';
  