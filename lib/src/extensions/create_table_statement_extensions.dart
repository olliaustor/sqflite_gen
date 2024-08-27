import 'package:sqflite_gen/src/converters/camel_case_to_underscore_converter.dart';
import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqlparser/sqlparser.dart';

/// [CreateTableStatement] extensions
extension CreateTableStatementX on CreateTableStatement {
  /// Converts table name into source code field name
  String toFieldName() => UnderscoreToCamelCaseConverter(
      startsWithUpperCase: false,).convert(tableName);

  /// Converts table name into source code class name
  String toClassName() => UnderscoreToCamelCaseConverter()
      .convert(tableName);

  /// Converts table name into valid dart file name (with underscores)
  String toFileName() => CamelCaseToUnderscoreConverter()
      .convert(tableName);
}