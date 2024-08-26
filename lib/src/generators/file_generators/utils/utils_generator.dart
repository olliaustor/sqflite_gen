import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

/// Generates utils file with small helpers used in the generated code
class UtilsGenerator extends FileGenerator {
  /// Output file name of generated file
  final String targetFileName = 'utils.dart';

  /// Content of output file
  final content = '''  
bool intToBool(int value) => value == 1;
int boolToInt(bool value) => value ? 1 : 0;
bool isNull(dynamic value) => value == null;

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
  isEmpty() => isNull(value);
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
