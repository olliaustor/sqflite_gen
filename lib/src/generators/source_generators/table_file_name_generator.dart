import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates a file name
class TableFileNameGenerator {
  /// Default file path
  final String targetFilePath = 'tables/%underscoreSqlTableName%/';

  /// Default filename with path and placeholders
  final String targetFileName = '%underscoreSqlTableName%%fileNameSuffix%.dart';

  /// Placeholder to be replaced with table name as filename
  final String placeholderUnderscoreSqlTableName = '%underscoreSqlTableName%';

  /// Placeholder for optional filename suffix
  final String placeholderSuffix = '%fileNameSuffix%';

  /// Generates a filename with full path
  ///
  /// It takes [statement] and the optional [fileNameSuffix] and
  /// [includeRelativePath] as parameters and returns a `String`.
  ///
  /// - `statements`: Parsed sql table create statements
  /// - `fileNameSuffix`: filename suffix (default value is empty string)
  /// - `includeRelativePath`: include file path or generate filename only
  ///
  /// Returns a `String` containing the full filename (including the filepath)
  String call(
    CreateTableStatement statement, {
    String fileNameSuffix = '',
    bool includeRelativePath = true,
  }) {
    final suffix = fileNameSuffix == '' ? '' : '_$fileNameSuffix';

    final fullFileName =
        (includeRelativePath ? targetFilePath : '') + targetFileName;

    final fileName = fullFileName
        .replaceAll(
          placeholderUnderscoreSqlTableName,
          statement.toFileName(),
        )
        .replaceAll(placeholderSuffix, suffix);

    return fileName;
  }
}
