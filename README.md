# Sqflite Gen

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

Open source code generator for unified sqlite database access for Flutter & Dart. 

## Overview
The goal of this package is to support the developer by taking over the repetitive tasks of rewriting database access
layers when using the package [sqflite][sqflite_link]. It parses the sql create script and generates models<br> provider 
and consts for accessing all tables. It also creates a database access layer and handles the automatic creating of all
tables on first run of the app.

It handles automatic type mapping for boolean, Uint8List and DateTime values.

The generated source follows the [best principles as provided by sqflite][sqflite_best_practices] (see section 
"SQL helpers").

---

## Installation 💻

**❗ In order to start using Sqflite Gen you must have the [Dart SDK][dart_install_link] installed on your machine.**

Install via `dart pub add`:

```sh
dart pub add sqflite_gen
```

Then run:
```sh
dart pub get
```
or
```sh
flutter pub get
```

Now SqfliteGen will generate the database access layer files for you by running:
```sh
dart run build_runner build
```

---

## Configuration
In order to make the package generate the required source code please place a file with the ending `.sql` in the 
assets directory of your app. The file must include all `create table` statements for the database. 

All generated files will be placed in/under the directory `lib/db`. 

---

## Overview

Autoincrement primary keys are supported.

For each table a subdirectory will be created in `lib/db/tables`. The package creates for each table a data model<br> 
table access provider and constants for unified access of table and fields.

The model file is named like the database table. It represents a table contains a property for each column of 
that table. It also contains the methods for converting to and from map and a `copyWith` method to create a new clone.

The provider class is named like the database table with the suffix `Provider`. It allows basic access to a table by 
providing methods for crud operations: `insert`<br> `get`<br> `update` and `delete`. For convenience<br> it also provides a 
`getAll` method which returns all record of the table.

Further constants are created for encapsulate the table name and the names of all columns.

---

## Usage examples

Import files for getting database access (replace the `example_app` with references to your app)

```dart
import 'package:example_app/db/database.dart';
import 'package:example_app/db/db.dart';
```

### Opening a database

Opening the database also contains a basic migration mechanism. This is currently only used to create all tables on the 
fly when opening the database for the first time. Afterward the database structure is not changed anymore.   

```dart
const dbName = 'test.db';
late Database database;
.
.
.
database = await openDatabaseWithMigration(dbName);
```

Many applications use one database and would never need to close it (it will be closed when the application is
terminated). If you want to release resources, you can close the database.

```dart
await database.close();
```

### Accessing database tables

Each table is represented by a model and a provider class. They encapsulate access in a typesafe way.

For the following examples we assume that the database table will look like this:
```sql
CREATE TABLE Test(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  text VARCHAR NOT NULL
);
```

#### Insert

```dart
final record = Test(text: 'This is a test');
final table = TestProvider(database);

final insertedRecord = await table.insert(record);
log(insertedRecord.id.toString());
```

Please note that the `insert` method automatically handles the autoincrement column `id` (when value is not provided 
explicitly). `insert` also returns a clone of the original `record` containing the value of the autoincrement column 
`id` (as given by the database).

#### Select

The `get` method expected a value for the primary key. 

```dart
final table = TestProvider(database);

final record = await table.get(1);
log(insertedRecord.text);
```

#### Update

```dart
final table = TestProvider(database);
final record = await table.get(1);

final changedRecord = record.copyWith(text: 'Changed text');
await table.update(changedRecord);
```

#### Delete

The `delete` method expected a value for the primary key.

```dart
final table = TestProvider(database);

final success = await table.delete(1);
log(success ? 'Successfully deleted' : 'Failing deleting record');
```

---

## Handling null values

Columns marked as nullable are represented as nullable fields in the model class. 
```sql
CREATE TABLE Test(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  text VARCHAR
);
```

This is an issue for the `copyWith` method as the given value can now basically represent 3 different actions:<br>
* Set value to new value
* Set value to null
* Keep value

To support this nullable fields are wrapped in the `copyWith` method:
```dart
// Initialize model
final record = Test(text: 'Original text');
log(record.text); // prints Original text

// Change nullable column text to a different string 
final changedRecord = record.copyWith(text: Wrapped.value('New text'));
log(record.text); // prints New text

// Keep value of column text 
final otherRecord = record.copyWith(); // same as: record.copyWith(text: null)
log(record.text); // prints Original text

// Change nullable column text to null value
final nulledRecord = record.copyWith(text: Wrapped.value(null));
log(record.text); // prints <null>

```


---

## Supported SQLite types

No validity check is done on values yet so please avoid non-supported types [https://www.sqlite.org/datatype3.html](https://www.sqlite.org/datatype3.html)

| Example Typenames From The CREATE TABLE Statement or CAST Expression                                          | Generated Dart Field Type |
|---------------------------------------------------------------------------------------------------------------|---------------------------| 
| INT<br>INTEGER<br>TINYINT<br>SMALLINT<br>MEDIUMINT<br>BIGINT<br>UNSIGNED BIG INT<br>INT2<br>INT8              | `int`                     | 
| CHARACTER<br>VARCHAR<br>VARYING CHARACTER<br>NCHAR<br>NATIVE CHARACTER<br>NVARCHAR<br>TEXT<br>CLOB<br>STRING  | `String`                  | 
| BLOB                                                                                                          | `Uint8List`               | 
| BOOL                                                                                                          | `bool`                    |
| DATE<br>DATETIME                                                                                              | `double`                  |
| REAL<br>DOUBLE<br>DOUBLE PRECISION<br>FLOAT<br>NUMERIC<br>DECIMAL                                             | `DateTime`                |

More information on supported types [here](https://github.com/tekartik/sqflite/blob/master/sqflite/doc/supported_types.md).

---

## Continuous Integration 🤖

Sqflite Gen uses a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link].

Out of the box<br> on each pull request and push<br> the CI `formats`<br> `lints`<br> and `tests` the code. This ensures the code 
remains consistent and behaves correctly as you add functionality or make changes. The project uses 
[Very Good Analysis][very_good_analysis_link] for a strict set of analysis options. 
Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---

## Running Tests 🧪

To run all unit tests:

```sh
dart pub global activate coverage 1.2.0
dart test --coverage=coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```
[sqflite_best_practices]: https://github.com/tekartik/sqflite/blob/master/sqflite/README.md
[sqflite_link]: https://pub.dev/packages/sqflite
[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows
