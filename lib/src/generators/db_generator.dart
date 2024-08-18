import 'package:sqflite_gen/src/generators/generator_base.dart';

class DbGenerator extends Generator {
  final String targetFileName = 'db.dart';

  final content = '''
export 'database_repository.dart';
export 'tables/tables.dart';
    ''';

  @override
  Future<GeneratorResult> generate() async {
    return GeneratorResult(
      targetFileName: targetFileName,
      content: content,
    );
  }
}
