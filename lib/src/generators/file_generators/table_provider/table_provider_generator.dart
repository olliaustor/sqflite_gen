import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/constructor/table_to_constructor_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/create/table_to_method_create_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/delete/table_to_method_delete_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/get/table_to_method_get_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/get_all/table_to_method_get_all_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/insert/table_to_method_insert_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/update/table_to_method_update_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/table_file_name_generator.dart';

import 'package:sqlparser/sqlparser.dart';

/// Generates file containing provider declaration for table
class TableProviderGenerator extends FileGenerator {
  /// Creates new object for given [statement]
  TableProviderGenerator(this.statement);

  /// [statement] of table to be processed
  final Either<CreateTableStatement, String> statement;

  /// Suffix to be added to the final filename
  final String fileNameSuffix = 'provider';

  /// Placeholder for constructor
  final String placeholderConstructor = '%constructor%';

  /// Placeholder for method create
  final String placeholderCreate = '%create%';

  /// Placeholder for method insert
  final String placeholderInsert = '%insert%';

  /// Placeholder for method get
  final String placeholderGet = '%get%';

  /// Placeholder for method getAll
  final String placeholderGetAll = '%get_all%';

  /// Placeholder for method delete
  final String placeholderDelete = '%delete%';

  /// Placeholder for method delete
  final String placeholderUpdate = '%update%';

  /// Placeholder for class name
  final String placeholderClassName = '%className%';

  /// Placeholder for filename in source
  final String placeholderFileName = '%fileName%';

  /// File content with placeholders
  final content = '''
import '../../utils.dart';  
import '%fileName%_model.dart';
import '%fileName%_values.dart';
import 'package:sqflite/sqflite.dart';

class %className%Provider {
%constructor%

  final Database db;

%create%
%insert%
%get%
%get_all%
%delete%
%update%
}
''';

  @override
  Future<FileGeneratorResult> generate() async {
    final createTableStatement = statement.asLeft();

    final constructorGenerator = TableToConstructorGenerator();
    final createGenerator = TableToMethodCreateGenerator();
    final insertGenerator = TableToMethodInsertGenerator();
    final getGenerator = TableToMethodGetGenerator();
    final getAllGenerator = TableToMethodGetAllGenerator();
    final deleteGenerator = TableToMethodDeleteGenerator();
    final updateGenerator = TableToMethodUpdateGenerator();

    final fullFileName = TableFileNameGenerator()(
      createTableStatement,
      fileNameSuffix: fileNameSuffix,
    );

    final fileContent = content
        .replaceAll(placeholderFileName, createTableStatement.toFileName())
        .replaceAll(placeholderClassName, createTableStatement.toClassName())
        .replaceAll(
          placeholderConstructor,
          constructorGenerator(createTableStatement),
        )
        .replaceAll(
          placeholderCreate,
          createGenerator(createTableStatement),
        )
        .replaceAll(
          placeholderInsert,
          insertGenerator(createTableStatement),
        )
        .replaceAll(
          placeholderGet,
          getGenerator(createTableStatement),
        )
        .replaceAll(
          placeholderGetAll,
          getAllGenerator(createTableStatement),
        )
        .replaceAll(
          placeholderDelete,
          deleteGenerator(createTableStatement),
        )
        .replaceAll(
          placeholderUpdate,
          updateGenerator(createTableStatement),
        );

    return FileGeneratorResult(
      targetFileName: fullFileName,
      content: fileContent,
    );
  }
}
