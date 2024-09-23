import 'dart:async';

import 'package:build/build.dart';
import 'package:sqflite_gen/src/sqflite_code_generator.dart';

class SqfliteDartCodeGenerator implements Builder {
  SqfliteDartCodeGenerator(BuilderOptions builderOptions) {
    //options = GeneratorOptions.fromJson(builderOptions.config);
  }

  //late GeneratorOptions options;

  @override
  Future<void> build(BuildStep buildStep) async {
    const targetFilePath = 'lib/db';

    final s = await buildStep.readAsString(buildStep.inputId);

    await SqfliteCodeGenerator().build(
      targetFilePath: targetFilePath,
      sqlContent: s,
    );
  }

  @override
  Map<String, List<String>> get buildExtensions => {
        '.sql': ['.foo', '.bar'],
      };
}
