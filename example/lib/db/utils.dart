bool intToBool(int value) => value == 1;
int boolToInt(bool value) => value ? 1 : 0;

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
  isEmpty() => value == null;
}
    