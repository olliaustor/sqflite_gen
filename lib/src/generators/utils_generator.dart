import 'package:sqflite_gen/src/generators/generator_base.dart';

class UtilsGenerator extends Generator {
  final String targetFileName = 'utils.dart';

  final content = '''
bool intToBool(int value) => value == 1;
int boolToInt(bool value) => value ? 1 : 0;
    ''';

  @override
  Future<GeneratorResult> generate() async {
    return GeneratorResult(
      targetFileName: targetFileName,
      content: content,
    );
  }
}
