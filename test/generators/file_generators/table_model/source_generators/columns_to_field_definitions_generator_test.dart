import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/columns_to_field_definitions_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
  );

  final columnDefinitionRequired = ColumnDefinition(
    columnName: 'text',
    typeName: 'STRING',
    constraints: [
      NotNull('id'),
    ],
  );

  group(
    'ColumnsToFieldDefinitionsGenerator',
    () => {
      test('empty list returns empty string', () {
        const expected = '';

        final result = ColumnsToFieldDefinitionsGenerator()(
          <ColumnDefinition>[],
        );

        expect(result, equals(expected));
      }),
      test('single column returns single line string', () {
        const expected = '    final int? id;';

        final result = ColumnsToFieldDefinitionsGenerator()(
          [columnDefinition],
        );

        expect(result, equals(expected));
      }),
      test('multiple column returns multiple line string', () {
        const expected = '    final int? id;\n    final String text;';

        final result = ColumnsToFieldDefinitionsGenerator()(
          [
            columnDefinition,
            columnDefinitionRequired,
          ],
        );

        expect(result, equals(expected));
      }),
    },
  );
}
