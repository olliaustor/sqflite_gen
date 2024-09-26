/// Abstract class to convert a [String] into another [String]
// ignore: one_member_abstracts
abstract class Converter {
  /// Converts a [String] into another [String].
  /// [source] Source [String] to be converted
  ///
  /// Returns converted [String]
  String convert(String source);
}
