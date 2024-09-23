import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates map constructor for given columns
class ColumnsToFromMapConstructorGenerator {
  /// Placeholder for class name
  final placeholderTableName = '%tableName%';

  /// Placeholder for list of parameters
  final placeholderParameters = '%parameters%';

  /// Constructor template with placeholders
  final content = '''
    return %tableName%(
%parameters%
    );''';

  /// Generates constructor for all columns in given [CreateTableStatement]
  ///  'statement': create table statement
  ///
  /// Returns [String] containing the constructor
  String call(CreateTableStatement statement) {
    final tableName = UnderscoreToCamelCaseConverter().convert(
      statement.tableName,
    );
    final sB = StringBuffer();

    for (final column in statement.columns) {
      final fieldName = column.toFieldName();
      sB.writeln('      $fieldName: $fieldName,');
    }

    return content
        .replaceAll(placeholderTableName, tableName)
        .replaceAll(placeholderParameters, sB.toString().trimRight());
  }
}
