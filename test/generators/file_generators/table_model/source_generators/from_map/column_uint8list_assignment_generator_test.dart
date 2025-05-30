import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/from_map/column_uint8list_to_assignment_generator.dart';
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

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
  );

  group(
    'ColumnUint8ListToAssignmentGenerator',
    () => {
      test('Uint8List generates valid assignment', () {
        const expected = 'map[myTableNameColumnVal] as Uint8List';

        final result = ColumnUint8ListToAssignmentGenerator()(
          statement,
          columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('Int8List? generates valid assignment', () {
        const expected = 'map[myTableNameColumnVal] as Uint8List?';

        final result = ColumnUint8ListToAssignmentGenerator()(
          statement,
          columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
