import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/constructor/columns_to_constructor_parameters_generator.dart';
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
    'ColumnsToConstructorParametersGenerator',
    () => {
      test('empty list returns empty string', () {
        const expected = '';

        final result = ColumnsToConstructorParametersGenerator()(
          <ColumnDefinition>[],
        );

        expect(result, equals(expected));
      }),
      test('single column returns single line string', () {
        const expected = '    this.id,';

        final result = ColumnsToConstructorParametersGenerator()(
          [columnDefinition],
        );

        expect(result, equals(expected));
      }),
      test('multiple column returns multiple line string', () {
        const expected = '    this.id,\n    required this.text,';

        final result = ColumnsToConstructorParametersGenerator()(
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
