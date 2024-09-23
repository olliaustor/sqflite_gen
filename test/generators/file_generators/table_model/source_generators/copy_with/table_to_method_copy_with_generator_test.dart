import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/copy_with/table_to_method_copy_with_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
  );

  final nullableColumnDefinition = ColumnDefinition(
    columnName: 'text',
    typeName: 'STRING',
    constraints: [NotNull('text')],
  );

  final statementWithoutColumns = CreateTableStatement(
    tableName: 'my_table_name',
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinition, nullableColumnDefinition],
  );

  final statementWithSingleColumn = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinition],
  );

  group(
    'TableToMethodCopyWithGenerator',
    () => {
      test('without columns generate method without assignments', () {
        const expected = '''
  MyTableName copyWith() {
    return MyTableName(

    );
  }
''';

        final result = TableToMethodCopyWithGenerator()(
          statementWithoutColumns,
        );

        expect(result, equals(expected));
      }),
      test('with single column generates valid method', () {
        const expected = '''
  MyTableName copyWith({
    Wrapped<int?>? id,
  }) {
    return MyTableName(
      id: isNull(id) ? this.id : (id!.value),
    );
  }
''';

        final result = TableToMethodCopyWithGenerator()(
          statementWithSingleColumn,
        );

        expect(result, equals(expected));
      }),
      test('with two columns generates valid method', () {
        const expected = '''
  MyTableName copyWith({
    Wrapped<int?>? id,
    String? text,
  }) {
    return MyTableName(
      id: isNull(id) ? this.id : (id!.value),
      text: isNull(text) ? this.text : text!,
    );
  }
''';

        final result = TableToMethodCopyWithGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
