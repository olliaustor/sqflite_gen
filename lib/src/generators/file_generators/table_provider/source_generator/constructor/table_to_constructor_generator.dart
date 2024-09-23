import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqlparser/sqlparser.dart';

/// Generates constructor for table
class TableToConstructorGenerator {
  /// Placeholder for class name
  final String placeholderClassName = '%className%';

  /// Content containing replacement values
  final content = '  %className%Provider(this.db);';

  /// Generates constructor from given [CreateTableStatement]
  ///  'columnDefinition': column definition
  ///
  /// Returns [String] containing the constructor
  String call(CreateTableStatement statement) {
    final text = content.replaceAll(
      placeholderClassName,
      statement.toClassName(),
    );

    return text;
  }
}
