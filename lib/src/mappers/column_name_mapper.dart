import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';
import 'package:sqflite_gen/src/mappers/mapper_base.dart';

class ColumnNameMapper extends Mapper {
  ColumnNameMapper(this.sqlTableName, this.sqlColumnName) {}

  final CamelCaseFomatter camelCaseFormatter = CamelCaseFomatter();

  final String placeholderSqlTableName = '%sqlTableName%';
  final String placeholderSqlColumnName = '%sqlColumnName%';
  final String constColumnName = '%sqlTableName%Column%sqlColumnName%';

  final String sqlTableName;
  final String sqlColumnName;

  @override
  MapEntry<String, String> map() {
    final tableName = constColumnName
        .replaceAll(
          placeholderSqlTableName,
          camelCaseFormatter.format(
            sqlTableName,
            startsWithUpperCase: false,
          ),
        )
        .replaceAll(
          placeholderSqlColumnName,
          camelCaseFormatter.format(
            sqlColumnName,
          ),
        );

    return MapEntry(
      sqlColumnName,
      tableName,
    );
  }
}
