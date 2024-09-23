import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/from_map/column_int_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'INT',
  );

  final columnDefinitionNotNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'INT',
    constraints: [NotNull('val')],
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
  );

  group(
    'ColumnIntToAssignmentGenerator',
    () => {
      test('Int generates valid assignment', () {
        const expected = 'map[myTableNameColumnVal] as int';

        final result = ColumnIntToAssignmentGenerator()(
          statement,
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('Int? generates valid assignment', () {
        const expected = 'map[myTableNameColumnVal] as int?';

        final result = ColumnIntToAssignmentGenerator()(
          statement,
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
