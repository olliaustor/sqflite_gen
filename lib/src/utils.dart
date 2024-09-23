import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Converts a list of sql table parsing results and returns the create
/// statements for the valid table definitions.
///
/// It takes [statements] as parameter and returns a list of
/// `CreateTableStatement`.
///
/// - `statements`: List of sql table parser results
///
/// Returns a list  of 'CreateTableStatement' of valid create table statements.
List<CreateTableStatement> getValidTableStatements(
  List<Either<CreateTableStatement, String>> statements,
) {
  return statements
      .where((stmt) => stmt.isLeft())
      .map((stmt) => stmt.asLeft())
      .toList();
}
