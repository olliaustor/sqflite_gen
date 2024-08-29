import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_barrel/table_barrel_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final statement = Either<CreateTableStatement, String>.left(
    CreateTableStatement(
      tableName: 'MyTableName',
    ),
  );

  group(
      'TableBarrelGenerator',
      () => {
            test('has valid target filename', () async {
              const expected = 'tables/my_table_name/my_table_name.dart';
              final generator = TableBarrelGenerator(statement);
              final result = await generator.generate();

              expect(result.targetFileName, equals(expected));
            }),
            test('has two exports', () async {
              final generator = TableBarrelGenerator(statement);
              final result = await generator.generate();

              final regEx = RegExp('export');
              final amount = regEx
                  .allMatches(result.content)
                  .length;
              expect(amount, equals(2));
            }),
            test('exports ..._model.dart file', () async {
              const expected = "export 'my_table_name_model.dart'";
              final generator = TableBarrelGenerator(statement);
              final result = await generator.generate();

              expect(result.content, contains(expected));
            }),
            test('exports ..._provider.dart file', () async {
              const expected = "export 'my_table_name_provider.dart'";
              final generator = TableBarrelGenerator(statement);
              final result = await generator.generate();

              expect(result.content, contains(expected));
            }),
          });
}
