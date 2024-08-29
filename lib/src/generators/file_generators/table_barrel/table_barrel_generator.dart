import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_barrel/source_generators/table_file_name_generator.dart';

import 'package:sqlparser/sqlparser.dart';

/// Generates barrel file for all table specific files
class TableBarrelGenerator extends FileGenerator {
  /// Creates new object for given [statement]
  TableBarrelGenerator(this.statement);

  /// [statement] of table to be processed
  final Either<CreateTableStatement, String> statement;

  /// Placeholder for filename of sql table
  final String placeholderUnderscoreSqlTableName = '%underscoreSqlTableName%';

  /// Content of file (including placeholder(s))
  final content = '''
export '%underscoreSqlTableName%_model.dart';
export '%underscoreSqlTableName%_provider.dart';
''';

  @override
  Future<FileGeneratorResult> generate() async {
    final createTableStatement = statement.asLeft();
    final fileName = createTableStatement.toFileName();

    final mapReplacements = [
      MapEntry(
        placeholderUnderscoreSqlTableName,
        fileName,
      ),
    ];

    final fullFileName = TableFileNameGenerator()(
      createTableStatement,
    );

    final fileContent = content.replaceAllFromList(
      mapReplacements,
    );

    return FileGeneratorResult(
      targetFileName: fullFileName,
      content: fileContent,
    );
  }
}
