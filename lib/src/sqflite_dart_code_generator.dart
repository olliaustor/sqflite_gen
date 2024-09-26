// coverage:ignore-file
import 'dart:async';

import 'package:build/build.dart';
import 'package:sqflite_gen/src/sqflite_code_generator.dart';

/// Implementation of [Builder]. This is the entry point for this code generator
class SqfliteDartCodeGenerator implements Builder {
  /// Creates new object. [builderOptions] contains optional custom values
  /// declared in a yaml file
  SqfliteDartCodeGenerator(this.builderOptions) {
    //options = GeneratorOptions.fromJson(builderOptions.config);
  }

  /// Unprocessed options from yaml file
  late BuilderOptions builderOptions;

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
