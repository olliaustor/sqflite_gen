import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

import 'package:sqlparser/sqlparser.dart';

/// Generates tables barrel file to export all generated table files
class TablesBarrelGenerator extends FileGenerator {
  /// Creates new instance which uses given [statements]
  TablesBarrelGenerator(this.statements);

  /// Create table statements from sql file
  final List<Either<CreateTableStatement, String>> statements;

  /// Output file name of generated file
  final String targetFileName = 'tables/tables.dart';

  /// Placeholder to be replaced with filename
  final String placeholderFileName = '%fileName%';

  /// Source code line for exporting a file in the barrel file
  final String exportLine = '''export '%fileName%/%fileName%.dart';''';

  @override
  Future<FileGeneratorResult> generate() async {
    final sb = StringBuffer();

    for (final item in statements.where((stmt) => stmt.isLeft()))
    {
      final statement = item.asLeft();
      final fileName = statement.toFileName();
      final sourceLine = exportLine
        .replaceAll(placeholderFileName, fileName);

      sb.writeln(sourceLine);
    }

    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: sb.toString().trimRight(),
    );
  }
}
