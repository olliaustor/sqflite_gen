import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'ColumnDefinition extensions',
    () => {
      test('toFieldName returns valid string', () {
        final column = ColumnDefinition(
          columnName: 'test_column_name',
          typeName: 'INT',
        );

        final result = column.toFieldName();

        expect(result, equals('testColumnName'));
      }),
      group(
        'isPrimaryKey',
        () => {
          test('when marked as primary key returns true', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'INT',
              constraints: [PrimaryKeyColumn('test')],
            );

            final result = column.isPrimaryKey();

            expect(result, isTrue);
          }),
          test('when not marked as primary key returns false', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'INT',
            );

            final result = column.isPrimaryKey();

            expect(result, isFalse);
          }),
        },
      ),
      group(
        'isAutoIncrement',
        () => {
          test('when marked as auto increment returns true', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'INT',
              constraints: [
                PrimaryKeyColumn('test', autoIncrement: true),
              ],
            );

            final result = column.isAutoIncrement();

            expect(result, isTrue);
          }),
          test('when not marked as auto increment returns false', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'INT',
              constraints: [PrimaryKeyColumn('primary key')],
            );

            final result = column.isAutoIncrement();

            expect(result, isFalse);
          }),
        },
      ),
      group(
        'toFieldType',
        () => {
          test('unknown type throws exception', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'UNKNOWN',
              constraints: [NotNull('test')],
            );

            expect(
              column.toFieldType,
              throwsA(
                const TypeMatcher<StateError>(),
              ),
            );
          }),
          group(
            'nullable value',
            () => {
              test('not nullable converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'INT',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('nullable converts to int?', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'INT',
                );

                final result = column.toFieldType();

                expect(result, equals('int?'));
              }),
            },
          ),
          group(
            'to int',
            () => {
              test('INT converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'INT',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('INTEGER converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'INTEGER',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('TINYINT converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'TINYINT',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('SMALLINT converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'SMALLINT',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('MEDIUMINT converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'MEDIUMINT',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('BIGINT converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'BIGINT',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('UNSIGNED BIG INT converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'UNSIGNED BIG INT',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('INT2 converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'INT2',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
              test('INT8 converts to int', () {
                final column = ColumnDefinition(
                  columnName: 'test_column_name',
                  typeName: 'INT8',
                  constraints: [NotNull('test')],
                );

                final result = column.toFieldType();

                expect(result, equals('int'));
              }),
            },
          ),
        },
      ),
      group(
        'to String',
        () => {
          test('CHARACTER converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'CHARACTER',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
          test('VARCHAR converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'VARCHAR',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
          test('VARYING CHARACTER converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'VARYING CHARACTER',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
          test('NCHAR converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'NCHAR',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
          test('NATIVE CHARACTER converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'NATIVE CHARACTER',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
          test('NVARCHAR converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'NVARCHAR',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
          test('TEXT converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'TEXT',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
          test('CLOB converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'CLOB',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
          test('STRING converts to String', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'STRING',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('String'));
          }),
        },
      ),
      group(
        'to Uint8List',
        () => {
          test('BLOB converts to Uint8List', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'BLOB',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('Uint8List'));
          }),
        },
      ),
      group(
        'to bool',
        () => {
          test('BOOL converts to bool', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'BOOL',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('bool'));
          }),
        },
      ),
      group(
        'to DateTime',
        () => {
          test('DATE converts to DateTime', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'DATE',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('DateTime'));
          }),
          test('DATETIME converts to DateTime', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'DATETIME',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('DateTime'));
          }),
        },
      ),
      group(
        'to double',
        () => {
          test('REAL converts to double', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'REAL',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('double'));
          }),
          test('DOUBLE converts to double', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'DOUBLE',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('double'));
          }),
          test('DOUBLE PRECISION converts to double', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'DOUBLE PRECISION',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('double'));
          }),
          test('FLOAT converts to double', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'FLOAT',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('double'));
          }),
          test('NUMERIC converts to double', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'NUMERIC',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('double'));
          }),
          test('DECIMAL converts to double', () {
            final column = ColumnDefinition(
              columnName: 'test_column_name',
              typeName: 'DECIMAL',
              constraints: [NotNull('test')],
            );

            final result = column.toFieldType();

            expect(result, equals('double'));
          }),
        },
      ),
    },
  );
}
