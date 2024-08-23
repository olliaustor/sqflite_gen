import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

import 'package:sqlparser/sqlparser.dart';

class TableBarrelGenerator extends FileGenerator {
  TableBarrelGenerator(this.statement);

  final Either<CreateTableStatement, String> statement;

  final String placeholderUnderscoreSqlTableName = '%underscoreSqlTableName%';

  final String targetFileName =
      'tables/%underscoreSqlTableName%/%underscoreSqlTableName%.dart';

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

    final fullFileName = _getFullFileName(mapReplacements);

    final fileContent = content.replaceAllFromList(mapReplacements);

    return FileGeneratorResult(
      targetFileName: fullFileName,
      content: fileContent,
    );
  }

  String _getFullFileName(List<MapEntry<String, String>> mapReplaceValues) {
    final fullFileName = targetFileName.replaceAllFromList(mapReplaceValues);

    return fullFileName;
  }
}
