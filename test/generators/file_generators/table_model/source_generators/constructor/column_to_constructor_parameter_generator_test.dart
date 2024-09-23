import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/constructor/column_to_constructor_parameter_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
  );

  final columnDefinitionRequired = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [
      NotNull('id'),
    ],
  );

  group(
    'ColumnToConstructorParameterGenerator',
    () => {
      test('generates valid parameter for not required value', () {
        const expected = 'this.id,';

        final result = ColumnToConstructorParameterGenerator()(
          columnDefinition,
        );

        expect(result, equals(expected));
      }),
      test('generates valid parameter for required value', () {
        const expected = 'required this.id,';

        final result = ColumnToConstructorParameterGenerator()(
          columnDefinitionRequired,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
