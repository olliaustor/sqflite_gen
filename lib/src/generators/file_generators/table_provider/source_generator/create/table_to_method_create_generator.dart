import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/constructor/columns_to_constructor_parameters_generator.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates method create for table
class TableToMethodCreateGenerator {
  /// Placeholder for field name
  final String placeholderFieldName = '%fieldName%';

  /// Content containing replacement values
  final content = '''
  List<String> create(int version) {
    return [%fieldName%TableCreate];
  }
''';

  /// Generates constructor from given [CreateTableStatement]
  ///  'columnDefinition': column definition
  ///
  /// Returns [String] containing the constructor
  String call(CreateTableStatement statement) {
    final text = content
        .replaceAll(
      placeholderFieldName,
      statement.toFieldName(),
    );

    return text;
  }
}
