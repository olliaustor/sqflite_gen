extension StringX on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
  String toStartWithLowerCase() => length > 0 ?this.replaceRange(0, 1, this[0].toLowerCase()):'';
  bool containsAny(Iterable<String>values) => values.any((v) => this.contains(v));
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
