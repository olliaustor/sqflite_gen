import 'package:sqflite_gen/src/generators/file_generators/table_barrel/source_generators/table_file_name_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final statement = CreateTableStatement(
    tableName: 'MyTableName',
  );

  group(
      'TableFileNameGenerator',
          () => {
        test('generates valid filename with empty suffix', () {
          const expected = 'tables/my_table_name/my_table_name.dart';
          final generator = TableFileNameGenerator();
          final result = generator(statement);

          expect(result, equals(expected));
        }),
        test('generates valid filename with given suffix', () {
          const expected = 'tables/my_table_name/my_table_name_model.dart';
          final generator = TableFileNameGenerator();
          final result = generator(statement, fileNameSuffix: 'model');

          expect(result, equals(expected));
        }),
      });
}
