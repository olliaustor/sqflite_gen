import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/create_table_statement_ext.dart';
import 'package:sqlparser/sqlparser.dart';

/// Parser for sql script
class CreateScriptParser {
  /// Sql parsing engine to convert [String] to parsed objects
  final SqlEngine engine = SqlEngine();

  /// Pattern to split sql script into distinct table creations
  final String splitPattern = ');';

  /// Parses given [String] into parsed objects. The sql text is expected to
  /// contain at least 1 sql table create script. The method will return a list
  /// of objects containing either the parsed sql table create or an error text.
  /// [sqlScript]: Text containing a sql table create script.
  /// Returns either a list of objects containing either the parsed sql table
  /// create or an error text.
  List<Either<CreateTableStatementExt, String>> parse(String sqlScript) {
    final parts = _splitSqlScript(sqlScript);
    final result = parts.map(_parse).toList();
    return result;
  }

  List<String> _splitSqlScript(String sqlScript) {
    final parts = sqlScript.split(splitPattern);
    return parts
        .where(
          (part) =>
              part.trim() != '' && part.toUpperCase().contains('CREATE TABLE'),
        )
        .map((part) => part + splitPattern)
        .toList();
  }

  Either<CreateTableStatementExt, String> _parse(String sqlScript) {
    final result = engine.parse(sqlScript);

    if (result.errors.isNotEmpty) {
      return Either.right(result.errors[0].message);
    }

    final stmt = result.rootNode as CreateTableStatement;
    final stmtExt = CreateTableStatementExt.from(
      stmt,
      sqlScript.trim(),
    );

    return Either.left(stmtExt);
  }
}
