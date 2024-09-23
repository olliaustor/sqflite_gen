import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_bool_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'BOOL',
  );

  final columnDefinitionlNotNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'BOOL',
    constraints: [NotNull('bval')],
  );

  group(
    'ColumnBoolToAssignmentGenerator',
    () => {
      test('bool generates valid assignment', () {
        const expected = 'boolToInt(val)';

        final result = ColumnBoolToAssignmentGenerator()(
          columnDefinitionlNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('bool? generates valid assignment', () {
        const expected = 'isNull(val) ? null : boolToInt(val!)';

        final result = ColumnBoolToAssignmentGenerator()(
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
