Create Table Test(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  text VARCHAR NOT NULL,
  number INTEGER NOT NULL,
  numeric DOUBLE NOT NULL,
  date DATE NOT NULL,
  is_checked BOOL NOT NULL,
  anything BLOB NOT NULL
);