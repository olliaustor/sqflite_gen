import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/list_of_table_providers_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates private method which returns all known table create scripts.
class MethodGetTablesCreatesGenerator {
  /// Placeholder to be replaced with a list of table create scripts
  final placeholderCreates = '%creates%';

  /// File content with placeholders
  final content = '''
List<GetTableProvider> _getTableCreates(Database db) {
  return [
%creates%
  ];
}
''';

  /// Generates private method which returns all known table create
  /// scripts.
  ///
  /// It takes [statements] as parameter and returns a `String`.
  ///
  /// - `statements`: Parsed sql table create statements
  ///
  /// Returns a `String` containing the formatted source for method
  /// _getTableCreates.
  String call(List<CreateTableStatement> statements) {
    final generator = ListOfTableProvidersGenerator();

    return content.replaceAll(
      placeholderCreates,
      generator(statements),
    );
  }
}
