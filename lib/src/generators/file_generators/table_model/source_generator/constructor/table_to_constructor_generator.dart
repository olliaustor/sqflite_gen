import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/constructor/columns_to_constructor_parameters_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates constructor for table
class TableToConstructorGenerator {
  /// Placeholder for class name
  final String placeholderClassName = '%className%';

  /// Placeholder for (list of) parameters
  final String placeholderParameters = '%parameters%';

  /// Content containing replacement values
  final content = '''
  %className%({
%parameters%
  });''';

  /// Generates constructor from given [CreateTableStatement]
  ///  'columnDefinition': column definition
  ///
  /// Returns [String] containing the constructor
  String call(CreateTableStatement statement) {
    final generator = ColumnsToConstructorParametersGenerator();

    final text = content
        .replaceAll(
          placeholderClassName,
          statement.toClassName(),
        )
        .replaceAll(
          placeholderParameters,
          generator(statement.columns),
        );

    return text;
  }
}
