import 'package:sqflite_gen/src/generators/file_generators/utils/utils_generator.dart';
import 'package:test/test.dart';

void main() {
  group(
    'UtilsGenerator',
    () => {
      test('has valid target filename', () async {
        final generator = UtilsGenerator();
        final result = await generator.generate();

        expect(result.targetFileName, equals('utils.dart'));
      }),
      test('generates function intToBool', () async {
        const expected = 'bool intToBool(int value) => value == 1;';

        final generator = UtilsGenerator();
        final result = await generator.generate();

        expect(result.content, contains(expected));
      }),
      test('generates function boolToInt', () async {
        const expected = 'int boolToInt(bool value) => value ? 1 : 0;';

        final generator = UtilsGenerator();
        final result = await generator.generate();

        expect(result.content, contains(expected));
      }),
      test('generates function isNull', () async {
        const expected = 'bool isNull(dynamic value) => value == null;';

        final generator = UtilsGenerator();
        final result = await generator.generate();

        expect(result.content, contains(expected));
      }),
      test('generates helper class Wrapped', () async {
        const expected = '''
class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
  isEmpty() => isNull(value);
}''';

        final generator = UtilsGenerator();
        final result = await generator.generate();

        expect(result.content, contains(expected));
      }),
    },
  );
}
