import 'package:sqflite_gen/src/generators/generator_base.dart';

class GenericProviderGenerator extends Generator {
  final String targetFileName = 'generic_provider.dart';

  final content = '''
abstract class GenericProvider<T> {
  List<String> create(int version);

  Future<T> insert(T general);
  Future<T?> get(int id);
  Future<int> delete(int id);
  Future<int> update(T general);
}
    ''';

  @override
  Future<GeneratorResult> generate() async {
    return GeneratorResult(
      targetFileName: targetFileName,
      content: content,
    );
  }
}
