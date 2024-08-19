extension StringX on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
  String toStartWithLowerCase() => length > 0 ?this.replaceRange(0, 1, this[0].toLowerCase()):'';
}
