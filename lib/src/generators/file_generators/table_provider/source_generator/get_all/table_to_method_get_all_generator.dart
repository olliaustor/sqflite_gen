import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates method getAll for table
class TableToMethodGetAllGenerator {
  /// Placeholder for class name
  final String placeholderClassName = '%className%';

  /// Placeholder for const name which represents the sql table name
  final String placeholderTableNameConst = '%tableNameConst%';

  /// Content containing replacement values
  final content = '''
  Future<List<%className%>> getAll() async {
    final maps = await db.query(%tableNameConst%);

    return maps.isEmpty
      ? []
      : maps.map((element) => %className%.fromMap(element)).toList();
  }
''';

  /// Generates getAll method from given [CreateTableStatement]
  ///  'statement': table statement
  ///
  /// Returns [String] containing the getAll method
  String call(CreateTableStatement statement) {
    final text = content
        .replaceAll(placeholderClassName, statement.toClassName())
        .replaceAll(
          placeholderTableNameConst,
          TableNameToConstNameConverter().convert(
            statement.tableName,
          ),
        );

    return text;
  }
}
