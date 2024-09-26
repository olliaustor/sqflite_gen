/// Base class for file generators
// ignore: one_member_abstracts
abstract class FileGenerator {
  /// Generates file content and returns the target file name and the file
  /// content
  Future<FileGeneratorResult> generate();
}

/// Resulting data from [FileGenerator]. Containing file name and file content
class FileGeneratorResult {
  /// Creates new object.
  /// [targetFileName] is the target file name
  /// [content] is the content of the file
  FileGeneratorResult({required this.targetFileName, required this.content});

  /// Target file name
  final String targetFileName;
  /// Generated file content
  final String content;
}
