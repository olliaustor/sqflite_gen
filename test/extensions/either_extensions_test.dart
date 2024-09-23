import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Either extensions',
    () => {
      group(
        'asRight',
        () => {
          test('returns right value when available', () {
            final either = Either<String, String>.right('test');
            expect(either.asRight(), equals('test'));
          }),
          test('throws EitherException when it is left value', () {
            final either = Either<String, String>.left('test');
            expect(
              either.asRight,
              throwsA(
                const TypeMatcher<EitherException>(),
              ),
            );
          }),
        },
      ),
      group(
        'asLeft',
        () => {
          test('returns left value when available', () {
            final either = Either<String, String>.left('test');
            expect(either.asLeft(), equals('test'));
          }),
          test('throws EitherException when it is right value', () {
            final either = Either<String, String>.right('test');
            expect(
              either.asLeft,
              throwsA(
                const TypeMatcher<EitherException>(),
              ),
            );
          }),
        },
      ),
      group(
        'EitherException',
        () => {
          test('toString returns given message', () {
            const expected = 'test text';
            const exception = EitherException(expected);

            expect(exception.toString(), equals(expected));
          }),
        },
      ),
    },
  );
}
