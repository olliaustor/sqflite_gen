import 'package:sqflite_gen/src/formatters/camel_case_formatter.dart';
import 'package:sqflite_gen/src/mappers/mapper_base.dart';

class TableNameMapper extends Mapper {
  TableNameMapper(this.sqlTableName) {}

  final CamelCaseFomatter camelCaseFormatter = CamelCaseFomatter();

  final String placeholderSqlTableName = '%sqlTableName%';
  final String constTableName = '%sqlTableName%TableName';

  final String sqlTableName;

  @override
  MapEntry<String, String> map() {
    final tableName = constTableName.replaceAll(
      placeholderSqlTableName,
      camelCaseFormatter.format(
        sqlTableName,
        startsWithUpperCase: false,
      ),
    );

    return MapEntry(
      sqlTableName,
      tableName,
    );
  }
}
