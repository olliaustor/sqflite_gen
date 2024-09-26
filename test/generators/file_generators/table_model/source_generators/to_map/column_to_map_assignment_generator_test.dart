import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_to_map_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionBool = ColumnDefinition(
    columnName: 'val',
    typeName: 'BOOL',
  );

  final columnDefinitionInt = ColumnDefinition(
    columnName: 'val',
    typeName: 'INT',
  );

  final columnDefinitionDouble = ColumnDefinition(
    columnName: 'val',
    typeName: 'DOUBLE',
  );

  final columnDefinitionString = ColumnDefinition(
    columnName: 'val',
    typeName: 'STRING',
  );

  final columnDefinitionDateTime = ColumnDefinition(
    columnName: 'val',
    typeName: 'DATE',
  );

  final columnDefinitionInt8List = ColumnDefinition(
    columnName: 'val',
    typeName: 'BLOB',
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
  );

  group(
    'ColumnToMapAssignmentGenerator',
    () => {
      test('bool generates valid assignment', () {
        const expected =
            '      myTableNameColumnVal: isNull(val) ? null : boolToInt(val!)';

        final result = ColumnToMapAssignmentGenerator()(
          statement,
          columnDefinitionBool,
        );

        expect(result, equals(expected));
      }),
      test('int generates valid assignment', () {
        const expected = '      myTableNameColumnVal: val';

        final result = ColumnToMapAssignmentGenerator()(
          statement,
          columnDefinitionInt,
        );

        expect(result, equals(expected));
      }),
      test('double generates valid assignment', () {
        const expected = '      myTableNameColumnVal: val';

        final result = ColumnToMapAssignmentGenerator()(
          statement,
          columnDefinitionDouble,
        );

        expect(result, equals(expected));
      }),
      test('string generates valid assignment', () {
        const expected = '      myTableNameColumnVal: val';

        final result = ColumnToMapAssignmentGenerator()(
          statement,
          columnDefinitionString,
        );

        expect(result, equals(expected));
      }),
      test('DateTime generates valid assignment', () {
        const expected = '      myTableNameColumnVal: isNull(val) ? null : '
            'val!.toUtc().millisecondsSinceEpoch';

        final result = ColumnToMapAssignmentGenerator()(
          statement,
          columnDefinitionDateTime,
        );

        expect(result, equals(expected));
      }),
      test('Int8List generates valid assignment', () {
        const expected = '      myTableNameColumnVal: val';

        final result = ColumnToMapAssignmentGenerator()(
          statement,
          columnDefinitionInt8List,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
