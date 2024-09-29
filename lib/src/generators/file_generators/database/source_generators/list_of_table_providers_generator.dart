import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/table_create_call_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates comma separated list of table provider constructor calls.
class ListOfTableProvidersGenerator {
  /// Generates comma separated list of table provider constructor calls.
  ///
  /// It takes [statements] as parameter and returns a `String`.
  ///
  /// - `statements`: Parsed sql table create statements
  ///
  /// Returns a `String` containing the formatted list list of table provider
  /// constructor calls
  String call(List<CreateTableStatement> statements) {
    final sb = StringBuffer();
    final generator = TableCreateCallGenerator();

    for (final statement in statements) {
      sb.writeln('    ${generator(statement)},');
    }

    return sb.toString().trimRight();
  }
}
