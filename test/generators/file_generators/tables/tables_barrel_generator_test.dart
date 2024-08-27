import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/generators/file_generators/tables/tables_barrel_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final singleStatement = [
    Either<CreateTableStatement, String>.left(
      CreateTableStatement(
        tableName: 'JustATable',
      ),
    ),
  ];
  final multipleStatments = [
    Either<CreateTableStatement, String>.left(
      CreateTableStatement(
        tableName: 'JustATable',
      ),
    ),
    Either<CreateTableStatement, String>.left(
      CreateTableStatement(
        tableName: 'AndAnotherTable',
      ),
    ),
  ];

  group(
      'TablesBarrelGenerator',
      () => {
            test('has valid target filename', () async {
              final generator = TablesBarrelGenerator([]);
              final result = await generator.generate();

              expect(result.targetFileName, equals('tables/tables.dart'));
            }),
            test('with no tables contains valid content', () async {
              const expected = '';

              final generator = TablesBarrelGenerator(singleStatement);
              final result = await generator.generate();

              expect(result.content, contains(expected));
            }),
            test('with one table contains valid content', () async {
              const expected = "export 'just_a_table/just_a_table.dart';";

              final generator = TablesBarrelGenerator(singleStatement);
              final result = await generator.generate();

              expect(result.content, contains(expected));
            }),
            test('with multiple tables contains valid content', () async {
              const expected = '''
export 'just_a_table/just_a_table.dart';
export 'and_another_table/and_another_table.dart';''';

              final generator = TablesBarrelGenerator(multipleStatments);
              final result = await generator.generate();

              expect(result.content, contains(expected));
            }),
          });
}
