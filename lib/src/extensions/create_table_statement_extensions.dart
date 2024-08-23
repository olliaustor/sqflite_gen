import 'package:sqflite_gen/src/converters/camel_case_to_underscore_converter.dart';
import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqlparser/sqlparser.dart';

extension CreateTableStatementX on CreateTableStatement {
  String toFieldName() => UnderscoreToCamelCaseConverter(startsWithUpperCase: false)
      .convert(tableName);
  String toClassName() => UnderscoreToCamelCaseConverter()
      .convert(tableName);
  String toFileName() => CamelCaseToUnderscoreConverter().convert(tableName);
}