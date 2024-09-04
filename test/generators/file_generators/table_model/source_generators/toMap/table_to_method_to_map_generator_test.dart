import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/constructor/table_to_constructor_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/toMap/table_to_method_to_map_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final columnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('id')],
  );

  final secondColumnDefinition = ColumnDefinition(
      columnName: 'text',
      typeName: 'STRING',
  );

  final autoIncrementColumnDefinition = ColumnDefinition(
    columnName: 'id',
    typeName: 'INT',
    constraints: [PrimaryKeyColumn('id', autoIncrement: true)],
  );

  final statementWithoutColumns = CreateTableStatement(
    tableName: 'my_table_name',
  );

  final statement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [columnDefinition, secondColumnDefinition],
  );

  final statementWithoutPrimaryKey = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [secondColumnDefinition],
  );

  final statementWithAutoIncrement = CreateTableStatement(
    tableName: 'my_table_name',
    columns: [autoIncrementColumnDefinition, secondColumnDefinition],
  );

  group(
    'TableToMethodToMapGenerator',
    () => {
      test('without columns generate empty map', () {
        const expected = '''
  Map<String, Object?> toMap() {
    var map = <String, Object?> {

    };
        
    return map;
  }  
''';

        final result = TableToMethodToMapGenerator()(
          statementWithoutColumns,
        );

        expect(result, equals(expected));
      }),
      test('with primary key generates valid method', () {
        const expected = '''
  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      myTableNameColumnId: id,
      myTableNameColumnText: text,
    };
        
    return map;
  }  
''';

        final result = TableToMethodToMapGenerator()(
          statement,
        );

        expect(result, equals(expected));
      }),
      test('with auto increment generates valid method', () {
        const expected = '''
  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      myTableNameColumnText: text,
    };
  
    if (id != null) {
      map[myTableNameColumnId] = id;
    }
        
    return map;
  }  
''';

        final result = TableToMethodToMapGenerator()(
          statementWithAutoIncrement,
        );

        expect(result, equals(expected));
      }),
      test('without primary key generates valid method', () {
        const expected = '''
  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      myTableNameColumnText: text,
    };
        
    return map;
  }  
''';

        final result = TableToMethodToMapGenerator()(
          statementWithoutPrimaryKey,
        );

        expect(result, equals(expected));
      }),
    },
  );
}
