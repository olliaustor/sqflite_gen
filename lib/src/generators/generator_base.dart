import 'dart:io';

abstract class Generator {
  Future<GeneratorResult> generate();
}

class GeneratorResult {
  GeneratorResult({required this.targetFileName, required this.content}) { }

  final String targetFileName;
  final  String content;
}