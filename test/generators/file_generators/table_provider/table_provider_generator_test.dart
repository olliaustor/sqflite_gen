import 'package:sqflite_gen/src/generators/file_generators/table_provider/table_provider_generator.dart';
import 'package:sqflite_gen/src/parser/create_script_parser.dart';
import 'package:test/test.dart';

void main() {
  const validCreateTable = '''
CREATE TABLE frameworks (
  id INTEGER NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  popularity REAL NOT NULL
);''';

  final parser = CreateScriptParser();
  final createTableStmt = parser.parse(
    validCreateTable,
  );
  final generator = TableProviderGenerator(
    createTableStmt[0],
  );

  group(
    'TableProviderGenerator',
        () => {
      test('has valid target filename', () async {
        const expected = 'tables/frameworks/frameworks_provider.dart';
        final result = await generator.generate();

        expect(result.targetFileName, equals(expected));
      }),
      test('has four exports', () async {
        final result = await generator.generate();

        final regEx = RegExp('import');
        final amount = regEx
            .allMatches(result.content)
            .length;
        expect(amount, equals(4));
      }),
      test('contains ..._values.dart import', () async {
        const expectedValue = "import 'frameworks_values.dart';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains ..._model.dart import', () async {
        const expectedValue = "import 'frameworks_model.dart';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains generic_provider.dart import', () async {
        const expectedValue = "import '../../generic_provider.dart';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains sqflite.dart import', () async {
        const expectedValue = "import 'package:sqflite/sqflite.dart';\n";

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains valid class declaration', () async {
        const expectedValue = 'class FrameworksProvider ';

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains constructor', () async {
        const expectedValue = 'FrameworksProvider(this.db);';

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains field for database', () async {
        const expectedValue = 'final Database db;\n';

        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains method create', () async {
        const expectedValue = 'List<String> create(int version) {';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains method insert', () async {
        const expectedValue = 'Future<Frameworks> insert(Frameworks frameworks) async {';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains method get', () async {
        const expectedValue = 'Future<Frameworks?> get(int id) async {';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains method delete', () async {
        const expectedValue = 'Future<bool> delete(int id) async {';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
      test('contains method update', () async {
        const expectedValue = 'Future<bool> update(Frameworks frameworks) async {';
        final result = await generator.generate();

        expect(result.content, contains(expectedValue));
      }),
    },
  );
}
