import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'CreateTableStatement extensions',
    () => {
      test('toFieldName returns valid string', () {
        final statement = CreateTableStatement(
          tableName: 'test_table_name',
        );

        final result = statement.toFieldName();

        expect(result, equals('testTableName'));
      }),
      test('toClassName returns valid string', () {
        final statement = CreateTableStatement(
          tableName: 'test_table_name',
        );

        final result = statement.toClassName();

        expect(result, equals('TestTableName'));
      }),
      test('toFileName returns valid string', () {
        final statement = CreateTableStatement(
          tableName: 'TestTableName',
        );

        final result = statement.toFileName();

        expect(result, equals('test_table_name'));
      })
    },
  );
}
