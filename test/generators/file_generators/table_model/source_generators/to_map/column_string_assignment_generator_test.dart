import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_string_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'STRING',
  );

  final columnDefinitionNotNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'STRING',
    constraints: [NotNull('val')],
  );

  group(
    'ColumnStringToAssignmentGenerator',
    () => {
      test('String generates valid assignment', () {
        const expected = 'val';

        final result = ColumnStringToAssignmentGenerator()(
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('String? generates valid assignment', () {
        const expected = 'val';

        final result = ColumnStringToAssignmentGenerator()(
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),

    },
  );
}
