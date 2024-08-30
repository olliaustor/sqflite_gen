import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates a file name
class TableFileNameGenerator {
  /// Default filename with path and placeholders
  final String targetFileName =
      'tables/%underscoreSqlTableName%/%underscoreSqlTableName%%fileNameSuffix%.dart';

  /// Placeholder to be replaced with table name as filename
  final String placeholderUnderscoreSqlTableName = '%underscoreSqlTableName%';
  /// Placeholder for optional filename suffix
  final String placeholderSuffix = '%fileNameSuffix%';

  /// Generates a filename with full path
  ///
  /// It takes [statement] and the optional [fileNameSuffix] as parameters and
  /// returns a `String`.
  ///
  /// - `statements`: Parsed sql table create statements
  /// - `fileNameSuffix`: filename suffix (default value is empty string)
  ///
  /// Returns a `String` containing the full filename (including the filepath)
  String call(CreateTableStatement statement, {String fileNameSuffix = ''}) {
    final suffix = fileNameSuffix == ''
      ? ''
      : '_$fileNameSuffix';

    final fileName = targetFileName
        .replaceAll(placeholderUnderscoreSqlTableName, statement.toFileName(),)
        .replaceAll(placeholderSuffix, suffix);

    return fileName;
  }
}
