import 'package:sqflite_gen/src/generators/file_generators/generic_provider/generic_provider_generator.dart';
import 'package:test/test.dart';

void main() {
  group('GenericRepositoryGenerator', () => {
    test('has valid target filename', () async {
      final generator = GenericProviderGenerator();
      final result = await generator.generate();

      expect(result.targetFileName, equals('generic_provider.dart'));
    }),

    test('contains valid content', () async {
      const expected = '''
abstract class GenericProvider<T> {
  List<String> create(int version);

  Future<T> insert(T general);
  Future<T?> get(int id);
  Future<int> delete(int id);
  Future<int> update(T general);
}
''';

      final generator = GenericProviderGenerator();
      final result = await generator.generate();

      expect(result.content, contains(expected));
    }),
  });
}
