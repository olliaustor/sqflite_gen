import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/from_map/column_datetime_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'DATE',
  );

  final columnDefinitionNotNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'DATE',
    constraints: [NotNull('val')],
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
  );

  group(
    'ColumnDateTimeToAssignmentGenerator',
    () => {
      test('DateTime generates valid assignment', () {
        const expected = 'DateTime.fromMillisecondsSinceEpoch(map[myTableNameColumnVal] as int, isUtc: true,)';

        final result = ColumnDateTimeToAssignmentGenerator()(
          statement, columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('DateTime? generates valid assignment', () {
        const expected = 'isNull(map[myTableNameColumnVal]) ? null : DateTime.fromMillisecondsSinceEpoch(map[myTableNameColumnVal] as int, isUtc: true,)';

        final result = ColumnDateTimeToAssignmentGenerator()(
          statement, columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),

    },
  );
}
