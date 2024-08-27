import 'package:fpdart/fpdart.dart';

/// Exception thrown by either extension
class EitherException implements Exception {
  /// Creates new EitherException with given parameter [message]
  const EitherException([this.message = '']);

  /// Message text
  final String message;

  @override
  String toString() {
    return message;
  }
}

/// Either extensions
extension EitherX<L, R> on Either<L, R> {
  /// Returns [R] of right value
  R asRight() {
    if (isLeft()) {
      throw const EitherException('no right value available');
    }

    return (this as Right).value as R;
  }

  /// Returns [L] of left value
  L asLeft() {
    if (isRight()) {
      throw const EitherException('no left value available');
    }

    return (this as Left).value as L;
  }
}