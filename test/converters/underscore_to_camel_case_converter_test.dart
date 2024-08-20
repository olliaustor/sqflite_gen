import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:test/test.dart';

void main() {
  group(
    'CamelCaseFormatter',
    () => {
      test('test with startWithUppercase=true converts to Test', () {
        final converter = UnderscoreToCamelCaseConverter();
        final result = converter.convert('test');
        expect(result, equals('Test'));
      }),
      test('test with startWithUppercase=false converts to test', () {
        final converter = UnderscoreToCamelCaseConverter(
          startsWithUpperCase: false,
        );
        final result = converter.convert('test');
        expect(result, equals('test'));
      }),
      test('testMe converts to TestMe', () {
        final converter = UnderscoreToCamelCaseConverter();
        final result = converter.convert('testMe');
        expect(result, equals('TestMe'));
      }),
      test('test_me converts to TestMe', () {
        final converter = UnderscoreToCamelCaseConverter();
        final result = converter.convert('test_me');
        expect(result, equals('TestMe'));
      }),
    },
  );
}
