import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/copy_with/column_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'val',
    typeName: 'INT',
  );

  final columnDefinitionNotNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'INT',
    constraints: [NotNull('val')],
  );

  final columnDefinitionPrimary = ColumnDefinition(
    columnName: 'val',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('val')],
  );

  group(
    'ColumnToParameterGenerator',
    () => {
      test('nullable column returns valid string', () {
        const expected = '      val: isNull(val) ? this.val : (val!.value)';

        final result = ColumnToAssignmentGenerator()(
          columnDefinition,
        );

        expect(result, equals(expected));
      }),
      test('not nullable column returns valid string', () {
        const expected = '      val: isNull(val) ? this.val : val!';

        final result = ColumnToAssignmentGenerator()(
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('primary column returns valid string', () {
        const expected = '      val: isNull(val) ? this.val : (val!.value)';

        final result = ColumnToAssignmentGenerator()(
          columnDefinition,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
