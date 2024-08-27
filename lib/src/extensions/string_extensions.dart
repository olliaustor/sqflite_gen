extension StringX on String {
  /// Converts [String] into all lowercase except for first character
  /// test Me NOW -> Test me now
  String toCapitalized() => length > 0
      ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
      : '';

  /// Converts [String] into capitalized words (each word separated by space
  /// starts with uppercase afterwards)
  /// test me NOW -> Test Me Now
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  /// Converts [String] to start with lowercase
  /// TesT -> tesT
  String toStartWithLowerCase() => length > 0
      ? replaceRange(0, 1, this[0].toLowerCase())
      : '';

  /// Checks [String] if it contains any of the given [values]
  /// Returns ´true´ if any of the values is contained false otherwise
  bool containsAny(Iterable<String>values) => values.any(contains);

  /// Replaces all values in [String] with given [mapReplaceValues]
  /// Each value is a [MapEntry] where the ´key` is the placeholder which has to
  /// be replaced and the ´value´ is the text which has to be inserted instead.
  String replaceAllFromList(List<MapEntry<String, String>> mapReplaceValues) {
    var text = this;

    for (final mapEntry in mapReplaceValues) {
      final key = mapEntry.key;
      final value = mapEntry.value;

      text = text.replaceAll(key, value);
    }

    return text;
  }
}
