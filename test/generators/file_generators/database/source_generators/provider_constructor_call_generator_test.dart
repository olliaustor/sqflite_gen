import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/provider_constructor_call_generator.dart';
import 'package:sqlparser/sqlparser.dart';
import 'package:test/test.dart';

void main() {
  final validStatement = CreateTableStatement(
    tableName: 'example_table',
  );

  group(
    'ProviderConstructorCallGenerator',
    () => {
      test('builds valid provider class name', () {
        final generator = ProviderConstructorCallGenerator();
        final result = generator(validStatement);

        expect(result, equals('ExampleTableProvider(db)'));
      }),
    },
  );
}
