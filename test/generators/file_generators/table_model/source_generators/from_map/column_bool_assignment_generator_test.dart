import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/from_map/column_bool_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'BOOL',
  );

  final columnDefinitionNotNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'BOOL',
    constraints: [NotNull('bval')],
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
  );

  group(
    'ColumnBoolToAssignmentGenerator',
    () => {
      test('bool generates valid assignment', () {
        const expected = 'intToBool(map[myTableNameColumnVal] as int)';

        final result = ColumnBoolToAssignmentGenerator()(
          statement,
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('bool? generates valid assignment', () {
        const expected =
            'isNull(map[myTableNameColumnVal]) ? null : intToBool(map[myTableNameColumnVal] as int)';

        final result = ColumnBoolToAssignmentGenerator()(
          statement,
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
