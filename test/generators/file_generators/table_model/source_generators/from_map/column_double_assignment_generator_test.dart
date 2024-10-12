import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/from_map/column_double_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'DOUBLE',
  );

  final columnDefinitionNotNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'DOUBLE',
    constraints: [NotNull('val')],
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
  );

  group(
    'ColumnDoubleToAssignmentGenerator',
    () => {
      test('double generates valid assignment', () {
        const expected = 'map[myTableNameColumnVal] as double';

        final result = ColumnDoubleToAssignmentGenerator()(
          statement,
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('double? generates valid assignment', () {
        const expected = 'map[myTableNameColumnVal] as double?';

        final result = ColumnDoubleToAssignmentGenerator()(
          statement,
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
