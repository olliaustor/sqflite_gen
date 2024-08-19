const String dealersTableName = 'Dealers';
const String dealersColumnDealerId = 'dealer_id';
const String dealersColumnDealerName = 'dealer_name';
const String dealersColumnDealerAddress = 'dealer_address';

const String dealersCreate = '''
CREATE TABLE $dealersTableName (
 $dealersColumnDealerId INTEGER PRIMARY KEY AUTOINCREMENT,
 $dealersColumnDealerName VARCHAR(50) NOT NULL,
 $dealersColumnDealerAddress VARCHAR(100),
)
''';
  