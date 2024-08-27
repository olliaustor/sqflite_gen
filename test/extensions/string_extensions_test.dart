import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:test/test.dart';

void main() {
  group(
      'String extensions',
      () => {
            group(
              'toCapitalized',
              () => {
                test('empty string returns empty string', () {
                  final result = ''.toCapitalized();
                  expect(result, equals(''));
                }),
                test('single character string stays single character string',
                    () {
                  final result = 'w'.toCapitalized();
                  expect(result, equals('W'));
                }),
                test(
                    'returns string with all lower case expect first character',
                    () {
                  final result =
                      'this IS a Test t0 test 8 random WOrds'.toCapitalized();
                  expect(
                      result, equals('This is a test t0 test 8 random words'));
                }),
              },
            ),
            group(
                'toTitleCase',
                () => {
                      test('empty string returns empty string', () {
                        final result = ''.toTitleCase();
                        expect(result, equals(''));
                      }),
                      test(
                          'single character string stays single character string',
                          () {
                        final result = 'w'.toTitleCase();
                        expect(result, equals('W'));
                      }),
                      test('multiple single chars stays single chars', () {
                        final result = 'a b c d'.toTitleCase();
                        expect(result, equals('A B C D'));
                      }),
                      test(
                          'changes all words to start with uppercase and everything else id lowercase',
                          () {
                        final result = 'this iS a Test t0 test 8 random WOrds'
                            .toTitleCase();
                        expect(result,
                            equals('This Is A Test T0 Test 8 Random Words'));
                      }),
                    }),
            group(
                'toStartWithLowerCase',
                () => {
                      test('empty string returns empty string', () {
                        final result = ''.toStartWithLowerCase();
                        expect(result, equals(''));
                      }),
                      test(
                          'single character string stays single character string',
                          () {
                        final result = 'W'.toStartWithLowerCase();
                        expect(result, equals('w'));
                      }),
                      test(
                          'changes all word to start with lowercase',
                          () {
                        final result = 'This IS a Test t0 test 8 random WOrds'
                            .toStartWithLowerCase();
                        expect(result,
                            equals('this IS a Test t0 test 8 random WOrds'));
                      }),
                    }),
            group(
                'containsAny',
                () => {
                      test('empty string returns false', () {
                        final result = ''.containsAny(['test']);
                        expect(result, equals(false));
                      }),
                      test('call with empty list returns false', () {
                        final result = 'This IS a Test t0 test 8 random WOrds'
                            .containsAny([]);
                        expect(result, equals(false));
                      }),
                      test('call with not contained value returns false', () {
                        final result = 'This IS a Test t0 test 8 random WOrds'
                            .containsAny(['blubb']);
                        expect(result, equals(false));
                      }),
                      test('call with not contained value returns false', () {
                        final result = 'This IS a Test t0 test 8 random WOrds'
                            .containsAny([
                          'blubb',
                          'Test',
                        ]);
                        expect(result, equals(true));
                      }),
                    }),
            group(
                'replaceAllFromList',
                () => {
                      test('empty string returns empty string', () {
                        final map = [const MapEntry('test', 'value')];
                        final result = ''.replaceAllFromList(map);
                        expect(result, equals(''));
                      }),
                      test(
                          'string with empty replacement list returns same string',
                          () {
                        final map = <MapEntry<String, String>>[];
                        final result = 'test'.replaceAllFromList(map);
                        expect(result, equals('test'));
                      }),
                      test(
                          'string with different replacement list returns same string',
                          () {
                        final map = [const MapEntry('unknown', 'value')];
                        final result = 'test'.replaceAllFromList(map);
                        expect(result, equals('test'));
                      }),
                      test('replacement list replaces all occurrences', () {
                        final map = [const MapEntry('test', 'value')];
                        final result =
                            'test test blubb'.replaceAllFromList(map);
                        expect(result, equals('value value blubb'));
                      }),
                      test(
                          'replacement list with different values replaces all occurrences',
                          () {
                        final map = [
                          const MapEntry('test', 'value'),
                          const MapEntry('value', 'blubb'),
                        ];
                        final result =
                            'test test blubb'.replaceAllFromList(map);
                        expect(result, equals('blubb blubb blubb'));
                      }),
                    }),
          });
}
