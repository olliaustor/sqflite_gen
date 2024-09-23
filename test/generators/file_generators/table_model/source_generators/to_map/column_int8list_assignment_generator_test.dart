import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/to_map/column_int8list_to_assignment_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinitionNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'BLOB',
  );

  final columnDefinitionNotNullable = ColumnDefinition(
    columnName: 'val',
    typeName: 'BLOB',
    constraints: [NotNull('val')],
  );

  group(
    'ColumnInt8ListToAssignmentGenerator',
    () => {
      test('Int8List generates valid assignment', () {
        const expected = 'val';

        final result = ColumnInt8ListToAssignmentGenerator()(
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('Int8List? generates valid assignment', () {
        const expected = 'val';

        final result = ColumnInt8ListToAssignmentGenerator()(
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
