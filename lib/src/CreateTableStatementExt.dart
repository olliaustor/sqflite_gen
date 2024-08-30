import 'package:sqlparser/sqlparser.dart';

/// Slightly enhanced [CreateTableStatement]
class CreateTableStatementExt extends CreateTableStatement {
  /// Default constructor as defined in base class with one additional parameter
  CreateTableStatementExt({
    required super.tableName,
    required this.createSqlStatement,
    super.ifNotExists,
    super.columns,
    super.tableConstraints,
    super.withoutRowId,
    super.isStrict,
    super.driftTableName,
  });

  /// Creates [CreateTableStatementExt] from given [CreateTableStatement] and
  /// [String] containing the parsed sql
  factory CreateTableStatementExt.from(
    CreateTableStatement statement,
    String createSqlStatement,
  ) {
    return CreateTableStatementExt(
      tableName: statement.tableName,
      createSqlStatement: createSqlStatement,
      ifNotExists: statement.ifNotExists,
      columns: statement.columns,
      tableConstraints: statement.tableConstraints,
      withoutRowId: statement.withoutRowId,
      isStrict: statement.isStrict,
      driftTableName: statement.driftTableName,
    );
  }

  /// Create SQL statement which was parsed
  final String createSqlStatement;
}
