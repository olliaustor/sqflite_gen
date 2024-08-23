import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';

import 'package:sqlparser/sqlparser.dart';

class TablesBarrelGenerator extends FileGenerator {
  TablesBarrelGenerator(this.statements);

  final List<Either<CreateTableStatement, String>> statements;

  final String placeholderUnderscoreSqlTableName = '%underscoreSqlTableName%';

  final String targetFileName = 'tables/tables.dart';

  @override
  Future<FileGeneratorResult> generate() async {
    final sb = StringBuffer();

    for (final item in statements.where((stmt) => stmt.isLeft()))
    {
      final statement = item.asLeft();
      final fileName = statement.toFileName();

      sb.writeln('''export '$fileName/$fileName.dart';''');
    }

    return FileGeneratorResult(
      targetFileName: targetFileName,
      content: sb.toString().trimRight(),
    );
  }
}
