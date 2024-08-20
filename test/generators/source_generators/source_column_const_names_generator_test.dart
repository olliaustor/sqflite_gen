import 'package:sqflite_gen/src/generators/source_generators/source_column_const_names_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  group(
    'SourceColumnConstNamesGenerator',
    () => {
      test('single column converts to single line', () {
        final columns = [
          ColumnDefinition(columnName: 'column', typeName: 'type'),
        ];

        final generator = SourceColumnConstNamesGenerator(
          'table',
          columns,
        );
        final result = generator.generate();
        expect(result, equals("const String tableColumnColumn = 'column';"));
      }),
      test('multiple columns convert to multiple lines', () {
        final columns = [
          ColumnDefinition(columnName: 'column', typeName: 'type'),
          ColumnDefinition(columnName: 'other_column', typeName: 'type'),
        ];

        final generator = SourceColumnConstNamesGenerator(
          'table',
          columns,
        );
        final result = generator.generate();
        expect(
          result,
          equals('''
const String tableColumnColumn = 'column';
const String tableColumnOtherColumn = 'other_column';'''),
        );
      }),
      test('no columns converts to empty string', () {
        final generator = SourceColumnConstNamesGenerator(
          'table',
          [],
        );
        final result = generator.generate();
        expect(result, equals(''));
      }),
    },
  );
}
