import 'package:sqflite_gen/src/generators/file_generators/database/source_generators/list_of_table_providers_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates private method which returns all known table providers.
class MethodGetTablesProviderGenerator {
  /// Placeholder to be replaced with a list of table provider classes
  final placeholderProvider = '%provider%';

  /// File content with placeholders
  final content = '''
List<GenericProvider<Object>> _getTableProviders(Database db) {
  return [
%provider%
  ];
}
''';

  /// Generates private method which returns all known table providers.
  ///
  /// It takes [statements] as parameter and returns a `String`.
  ///
  /// - `statements`: Parsed sql table create statements
  ///
  /// Returns a `String` containing the formatted source for method _getTableProviders.
  String call(List<CreateTableStatement> statements) {
    final generator = ListOfTableProvidersGenerator();

    return content.replaceAll(
      placeholderProvider,
      generator(statements),
    );
  }
}
