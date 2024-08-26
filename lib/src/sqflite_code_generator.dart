import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite_gen/src/generators/file_generators/database/database_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/database_repository_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/db/db_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/file_generators/generic_provider/generic_provider_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/tables_barrel_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/utils/utils_generator.dart';
import 'package:sqflite_gen/src/generators/table/table_barrel_generator.dart';
import 'package:sqflite_gen/src/generators/table/table_model_generator.dart';
import 'package:sqflite_gen/src/generators/table/table_provider_generator.dart';
import 'package:sqflite_gen/src/generators/table/table_values_generator.dart';
import 'package:sqflite_gen/src/parser/create_script_parser.dart';
import 'package:sqlparser/sqlparser.dart';

class SqfliteCodeGenerator {
  Future<void> build({
    required String targetFilePath,
    required String sqlContent,
  }) async {
    final engine = CreateScriptParser();
    final stmts = engine.parse(sqlContent);

    // Assemble all generators here -> but do not do anything
    final generators =
        _getStaticGenerators(stmts) +
        _getTableGenerators(stmts);

    // Now execute all generators resulting in filenames and file content
    final generatorResults = await Future.wait(generators.map(
      (generator) async => await generator.generate(),
    ));

    // Write all files here. Any error will be part of the respective file
    await _writeFiles(targetFilePath, generatorResults);
  }

  List<FileGenerator> _getStaticGenerators(List<Either<CreateTableStatement, String>> statements) {
    return [
      DbGenerator(),
      GenericProviderGenerator(),
      UtilsGenerator(),
      DatabaseRepositoryGenerator(),
      DatabaseGenerator(statements),
      TablesBarrelGenerator(statements),
    ];
  }

  List<FileGenerator> _getTableGenerators(
      List<Either<CreateTableStatement, String>> statements) {

    return statements.map((stmt) => [
      TableValuesGenerator(stmt),
      TableModelGenerator(stmt),
      TableProviderGenerator(stmt),
      TableBarrelGenerator(stmt),
    ]).expand((i) => i).toList();
  }

  Future<void> _writeFiles(
    String targetPath,
    List<FileGeneratorResult> generatorResults,
  ) async {
    await Future.forEach(
        generatorResults,
        (generatorResult) => _writeFile(
              targetPath,
              generatorResult,
            ));
  }

  Future<void> _writeFile(
    String targetPath,
    FileGeneratorResult generatorResult,
  ) async {
    final targetFileName = Path.join(
      targetPath,
      generatorResult.targetFileName,
    );
    await File(targetFileName).create(recursive: true);
    await File(targetFileName).writeAsString(generatorResult.content);
  }
}
