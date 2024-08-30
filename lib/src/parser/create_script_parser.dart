import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/CreateTableStatementExt.dart';
import 'package:sqlparser/sqlparser.dart';

class CreateScriptParser {
  final SqlEngine engine = SqlEngine();

  final String splitPattern = ');';

  List<Either<CreateTableStatementExt, String>> parse(String sqlScript) {
    var parts = _splitSqlScript(sqlScript);
    final result = parts.map(_parse).toList();
    return result;
  }

  List<String> _splitSqlScript(String sqlScript) {
    var parts = sqlScript.split(splitPattern);
    return parts
        .where((part) =>
            part.trim() != '' && part.toUpperCase().contains("CREATE TABLE"))
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
