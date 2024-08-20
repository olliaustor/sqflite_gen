import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

class UtilsGenerator extends FileGenerator {
  final String targetFileName = 'utils.dart';

  final content = '''
bool intToBool(int value) => value == 1;
int boolToInt(bool value) => value ? 1 : 0;
    ''';

  @override
  Future<FileGeneratorResult> generate() async {
    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: content,
    );
  }
}
