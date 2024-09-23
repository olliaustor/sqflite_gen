import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_int_to_assignment_generator.dart';
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

  group(
    'ColumnIntToAssignmentGenerator',
    () => {
      test('String generates valid assignment', () {
        const expected = 'val';

        final result = ColumnIntToAssignmentGenerator()(
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('String? generates valid assignment', () {
        const expected = 'val';

        final result = ColumnIntToAssignmentGenerator()(
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
