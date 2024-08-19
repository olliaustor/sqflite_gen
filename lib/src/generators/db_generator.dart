import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

class DbGenerator extends FileGenerator {
  final String targetFileName = 'db.dart';

  final content = '''
export 'database_repository.dart';
export 'tables/tables.dart';
    ''';

  @override
  Future<FileGeneratorResult> generate() async {
    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: content,
    );
  }
}
