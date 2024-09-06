import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/toMap/column_datetime_to_assignment_generator.dart';
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

  group(
    'ColumnDateTimeToAssignmentGenerator',
    () => {
      test('DateTime generates valid assignment', () {
        const expected = 'val.toUtc().millisecondsSinceEpoch';

        final result = ColumnDateTimeToAssignmentGenerator()(
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('DateTime? generates valid assignment', () {
        const expected = 'isNull(val) ? null : val!.toUtc().millisecondsSinceEpoch';

        final result = ColumnDateTimeToAssignmentGenerator()(
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),

    },
  );
}
