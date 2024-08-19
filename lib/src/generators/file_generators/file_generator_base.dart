abstract class FileGenerator {
  Future<FileGeneratorResult> generate();
}

class FileGeneratorResult {
  FileGeneratorResult({required this.targetFileName, required this.content}) { }

  final String targetFileName;
  final  String content;
}