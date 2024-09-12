import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/fromMap/column_int8list_to_assignment_generator.dart';
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
    'ColumnInt8ListToAssignmentGenerator',
    () => {
      test('Int8List generates valid assignment', () {
        const expected = 'map[myTableNameColumnVal] as Int8List';

        final result = ColumnInt8ListToAssignmentGenerator()(
          statement, columnDefinitionNotNullable,
        );

        expect(result, equals(expected));
      }),
      test('Int8List? generates valid assignment', () {
        const expected = 'map[myTableNameColumnVal] as Int8List?';

        final result = ColumnInt8ListToAssignmentGenerator()(
          statement, columnDefinitionNullable,
        );

        expect(result, equals(expected));
      }),

    },
  );
}
