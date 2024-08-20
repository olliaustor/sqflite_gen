import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

class GenericProviderGenerator extends FileGenerator {
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
  Future<FileGeneratorResult> generate() async {
    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: content,
    );
  }
}
