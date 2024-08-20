const String dealersTable = 'Dealers';
const String dealersColumnDealerId = 'dealer_id';
const String dealersColumnDealerName = 'dealer_name';
const String dealersColumnDealerAddress = 'dealer_address';

const String dealersTableCreate = '''
CREATE TABLE $dealersTable (
 $dealersColumnDealerId INTEGER PRIMARY KEY AUTOINCREMENT,
 $dealersColumnDealerName VARCHAR(50) NOT NULL,
 $dealersColumnDealerAddress VARCHAR(100),
)
''';
  