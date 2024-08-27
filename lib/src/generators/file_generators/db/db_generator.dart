import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

/// Generates db file which is basically a barrel file for accessing the
/// database layer.
class DbGenerator extends FileGenerator {
  /// Output file name of generated file
  final String targetFileName = 'db.dart';

  /// Content of output file
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
