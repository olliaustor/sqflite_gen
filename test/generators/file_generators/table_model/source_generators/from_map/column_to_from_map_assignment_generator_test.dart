import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/from_map/column_to_from_map_assignment_generator.dart';
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
    'ColumnToFromMapAssignmentGenerator',
    () => {
      test('bool generates valid assignment', () {
        const expected =
            '    final val = isNull(map[myTableNameColumnVal]) ? null : '
            'intToBool(map[myTableNameColumnVal] as int);';

        final result = ColumnToFromMapAssignmentGenerator()(
          statement,
          columnDefinitionBool,
        );

        expect(result, equals(expected));
      }),
      test('int generates valid assignment', () {
        const expected = '    final val = map[myTableNameColumnVal] as int?;';

        final result = ColumnToFromMapAssignmentGenerator()(
          statement,
          columnDefinitionInt,
        );

        expect(result, equals(expected));
      }),
      test('double generates valid assignment', () {
        const expected =
            '    final val = map[myTableNameColumnVal] as Double?;';

        final result = ColumnToFromMapAssignmentGenerator()(
          statement,
          columnDefinitionDouble,
        );

        expect(result, equals(expected));
      }),
      test('string generates valid assignment', () {
        const expected =
            '    final val = map[myTableNameColumnVal] as String?;';

        final result = ColumnToFromMapAssignmentGenerator()(
          statement,
          columnDefinitionString,
        );

        expect(result, equals(expected));
      }),
      test('DateTime generates valid assignment', () {
        const expected =
            '    final val = isNull(map[myTableNameColumnVal]) ? null : '
            'DateTime.fromMillisecondsSinceEpoch(map[myTableNameColumnVal] as '
            'int, isUtc: true,);';

        final result = ColumnToFromMapAssignmentGenerator()(
          statement,
          columnDefinitionDateTime,
        );

        expect(result, equals(expected));
      }),
      test('Int8List generates valid assignment', () {
        const expected =
            '    final val = map[myTableNameColumnVal] as Int8List?;';

        final result = ColumnToFromMapAssignmentGenerator()(
          statement,
          columnDefinitionInt8List,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
