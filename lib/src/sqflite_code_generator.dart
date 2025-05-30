// coverage:ignore-file
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite_gen/src/generators/file_generators/database/database_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/database_repository/database_repository_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/db/db_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_barrel/table_barrel_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/table_model_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/table_provider_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_values/table_values_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/tables/tables_barrel_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/utils/utils_generator.dart';
import 'package:sqflite_gen/src/parser/create_script_parser.dart';
import 'package:sqlparser/sqlparser.dart';

/// Code generator class
class SqfliteCodeGenerator {
  /// Creates code files based on the content of [targetFilePath] and
  /// [sqlContent]
  /// [targetFilePath] : All files/directories will be placed within this
  /// directory
  /// [sqlContent] : Sql script containing sql table create statements
  Future<void> build({
    required String targetFilePath,
    required String sqlContent,
  }) async {
    final engine = CreateScriptParser();
    final stmts = engine.parse(sqlContent);

    // Assemble all generators here -> but do not do anything
    final generators = _getStaticGenerators(stmts) + _getTableGenerators(stmts);

    // Now execute all generators resulting in filenames and file content
    final generatorResults = await Future.wait(
      generators.map(
        (generator) async => generator.generate(),
      ),
    );

    // Write all files here. Any error will be part of the respective file
    await _writeFiles(targetFilePath, generatorResults);
  }

  List<FileGenerator> _getStaticGenerators(
    List<Either<CreateTableStatement, String>> statements,
  ) {
    return [
      DbGenerator(),
      UtilsGenerator(),
      DatabaseRepositoryGenerator(),
      DatabaseGenerator(statements),
      TablesBarrelGenerator(statements),
    ];
  }

  List<FileGenerator> _getTableGenerators(
    List<Either<CreateTableStatement, String>> statements,
  ) {
    return statements
        .map(
          (stmt) => [
            TableValuesGenerator(stmt),
            TableModelGenerator(stmt),
            TableProviderGenerator(stmt),
            TableBarrelGenerator(stmt),
          ],
        )
        .expand((i) => i)
        .toList();
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
      ),
    );
  }

  Future<void> _writeFile(
    String targetPath,
    FileGeneratorResult generatorResult,
  ) async {
    final targetFileName = path.join(
      targetPath,
      generatorResult.targetFileName,
    );
    await File(targetFileName).create(recursive: true);
    await File(targetFileName).writeAsString(generatorResult.content);
  }
}
