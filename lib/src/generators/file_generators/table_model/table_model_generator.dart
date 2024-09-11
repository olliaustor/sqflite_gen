import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/fields/columns_to_field_definitions_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/constructor/table_to_constructor_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_model/source_generator/toMap/table_to_method_to_map_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_field_copy_with_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_field_from_map_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/table_file_name_generator.dart';

import 'package:sqlparser/sqlparser.dart';

/// Generates file containing model declaration for table
class TableModelGenerator extends FileGenerator {
  /// Creates new object for given [statement]
  TableModelGenerator(this.statement);

  /// [statement] of table to be processed
  final Either<CreateTableStatement, String> statement;

  /// Suffix to be added to the final filename
  final String fileNameSuffix = 'model';

  /// Suffix to be added to the import of the
  final String importFileNameValuesSuffix = 'values';

  /// Placeholder for values declaration file name
  final String placeholderValuesFileName = '%values_file_name%';

  /// Placeholder for class name
  final String placeholderClassName = '%className%';

  /// Placeholder for constructor
  final String placeholderConstructor = '%constructor%';

  /// Placeholder for field definitions
  final String placeholderFields = '%fields%';

  /// Placeholder for method toMap
  final String placeholderToMap = '%toMap%';

  /// Placeholder for method fromMap
  final String placeholderFromMap = '%fromMap%';

  /// Placeholder for method copyWith
  final String placeholderCopyWith = '%copyWith%';

  /// File content with placeholder
  final content = '''
import '%values_file_name%';
import '../../utils.dart';

class %className% {
%constructor%
  
%fields%

%toMap%
%fromMap%
%copyWith%
}
''';

  @override
  Future<FileGeneratorResult> generate() async {
    final createTableStatement = statement.asLeft();
    final sqlTableName = createTableStatement.tableName;

    final fileNameGenerator = TableFileNameGenerator();
    final constructorGenerator = TableToConstructorGenerator();
    final fieldsGenerator = ColumnsToFieldDefinitionsGenerator();
    final toMapGenerator = TableToMethodToMapGenerator();

    final fromMapGenerator =  SourceFieldFromMapGenerator(
      createTableStatement.tableName,
      createTableStatement.columns,
    );
    final copyWithGenerator = SourceFieldCopyWithGenerator(
      createTableStatement.tableName,
      createTableStatement.columns,
    );

    final fullFileName = TableFileNameGenerator()(
    createTableStatement,
    fileNameSuffix: fileNameSuffix,
    );

    final fileContent = content
        .replaceAll(placeholderValuesFileName, fileNameGenerator(
          createTableStatement,
          fileNameSuffix: importFileNameValuesSuffix,
          includeRelativePath: false,
          ),)
        .replaceAll(placeholderClassName, createTableStatement.toClassName())
        .replaceAll(placeholderConstructor,
          constructorGenerator(createTableStatement),)
        .replaceAll(placeholderFields,
          fieldsGenerator(createTableStatement.columns),)
        .replaceAll(placeholderToMap, toMapGenerator(createTableStatement))
        .replaceAll(placeholderFromMap, fromMapGenerator.generate())
        .replaceAll(placeholderCopyWith, copyWithGenerator.generate());


    return FileGeneratorResult(
    targetFileName: fullFileName,
    content: fileContent,
    );
    }
}
