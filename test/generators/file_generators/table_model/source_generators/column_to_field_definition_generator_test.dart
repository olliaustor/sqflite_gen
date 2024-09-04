import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/column_to_field_definition_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
  );

  final columnDefinitionRequired = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',constraints: [
    NotNull('id'),
  ],
  );

  group(
    'ColumnToFieldDefinitionGenerator',
    () => {
      test('generates valid parameter for not required value', () {
        const expected = 'final int? id;';

        final result = ColumnToFieldDefinitionGenerator()(
          columnDefinition,
        );

        expect(result, equals(expected));
      }),
      test('generates valid parameter for required value', () {
        const expected = 'final int id;';

        final result = ColumnToFieldDefinitionGenerator()(
          columnDefinitionRequired,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
