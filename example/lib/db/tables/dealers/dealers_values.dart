const String dealersTable = 'Dealers';
const String dealersColumnDealerId = 'dealer_id';
const String dealersColumnDealerName = 'dealer_name';
const String dealersColumnDealerAddress = 'dealer_address';

const String dealersTableCreate = '''
Create Table Dealers (
  dealer_id INTEGER PRIMARY KEY AUTOINCREMENT,
  dealer_name VARCHAR(50) NOT NULL,
  dealer_address VARCHAR(100)
);
''';
