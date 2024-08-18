import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as Path;

import 'package:sqflite_gen/src/generators/database_generator.dart';
import 'package:sqflite_gen/src/generators/database_repository_generator.dart';
import 'package:sqflite_gen/src/generators/db_generator.dart';
import 'package:sqflite_gen/src/generators/generator_base.dart';
import 'package:sqflite_gen/src/generators/generic_provider_generator.dart';
import 'package:sqflite_gen/src/generators/table/table_values_generator.dart';
import 'package:sqflite_gen/src/generators/utils_generator.dart';
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
    final generators = _getStaticGenerators() + _getTableGenerators(stmts);

    // Now execute all generators resulting in filenames and file content
    final generatorResults = await Future.wait(generators.map(
      (generator) async => await generator.generate(),
    ));

    // Write all files here. Any error will be part of the respective file
    await _writeFiles(targetFilePath, generatorResults);
  }

  List<Generator> _getStaticGenerators() {
    return [
      DbGenerator(),
      GenericProviderGenerator(),
      UtilsGenerator(),
      DatabaseRepositoryGenerator(),
      DatabaseGenerator()
    ];
  }

  List<Generator> _getTableGenerators(
      List<Either<CreateTableStatement, String>> statements) {

    return statements.map((stmt) => [
      TableValuesGenerator(stmt),
    ]).expand((i) => i).toList();
  }

  Future<void> _writeFiles(
    String targetPath,
    List<GeneratorResult> generatorResults,
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
    GeneratorResult generatorResult,
  ) async {
    final targetFileName = Path.join(
      targetPath,
      generatorResult.targetFileName,
    );
    await File(targetFileName).create(recursive: true);
    await File(targetFileName).writeAsString(generatorResult.content);
  }
}
