import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';
import 'package:test/test.dart';

void main() {
  group(
    'CamelCaseFormatter',
    () => {
      test('test with startWithUppercase=true converts to Test', () {
        final formatter = CamelCaseFormatter();
        final result = formatter.format('test');
        expect(result, equals('Test'));
      }),
      test('test with startWithUppercase=false converts to test', () {
        final formatter = CamelCaseFormatter();
        final result = formatter.format(
          'test',
          startsWithUpperCase: false,
        );
        expect(result, equals('test'));
      }),
      test('testMe converts to TestMe', () {
        final formatter = CamelCaseFormatter();
        final result = formatter.format('testMe');
        expect(result, equals('TestMe'));
      }),
      test('test_me converts to TestMe', () {
        final formatter = CamelCaseFormatter();
        final result = formatter.format('test_me');
        expect(result, equals('TestMe'));
      }),
    },
  );
}
