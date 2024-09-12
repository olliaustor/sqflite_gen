import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/fromMap/table_to_method_from_map_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
  );

  final columnPrimaryKey = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('id')],
  );

  final nullableColumnDefinition = ColumnDefinition(
      columnName: 'text',
      typeName: 'STRING',
      constraints: [NullColumnConstraint('text')]
  );

  final statementWithoutColumns = CreateTableStatement(
    tableName: 'my_table_name',
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinition, nullableColumnDefinition],
  );

  final statementWithPrimaryKey = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnPrimaryKey],
  );

  final statementWithSingleColumn = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinition],
  );

  final statementWithNullable = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [nullableColumnDefinition],
  );

  group(
    'TableToMethodFromMapGenerator',
    () => {
      test('without columns generate method without assignments', () {
        const expected = '''
  factory MyTableName.fromMap(Map<String, Object?> map) {


    return MyTableName(

    );
  }  
''';

        final result = TableToMethodFromMapGenerator()(
          statementWithoutColumns,
        );

        expect(result, equals(expected));
      }),
      test('with single column generates valid method', () {
        const expected = '''
  factory MyTableName.fromMap(Map<String, Object?> map) {
    final id = map[myTableNameColumnId] as int?;

    return MyTableName(
      id: id,
    );
  }  
''';

        final result = TableToMethodFromMapGenerator()(
          statementWithSingleColumn,
        );

        expect(result, equals(expected));
      }),
      test('with primary key column generates valid method', () {
        const expected = '''
  factory MyTableName.fromMap(Map<String, Object?> map) {
    final id = map[myTableNameColumnId] as int?;

    return MyTableName(
      id: id,
    );
  }  
''';

        final result = TableToMethodFromMapGenerator()(
          statementWithPrimaryKey,
        );

        expect(result, equals(expected));
      }),
      test('with two columns generates valid method', () {
        const expected = '''
  factory MyTableName.fromMap(Map<String, Object?> map) {
    final id = map[myTableNameColumnId] as int?;
    final text = map[myTableNameColumnText] as String?;

    return MyTableName(
      id: id, 
      text: text,
    );
  }  
''';

        final result = TableToMethodFromMapGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
      test('with nullable column generates valid method', () {
        const expected = '''
  factory MyTableName.fromMap(Map<String, Object?> map) {
    final text = map[myTableNameColumnText] as String?;

    return MyTableName(
      text: text,
    );
  }  
''';

        final result = TableToMethodFromMapGenerator()(
          statementWithNullable,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
