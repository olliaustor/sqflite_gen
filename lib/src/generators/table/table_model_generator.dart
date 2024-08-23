import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/converters/camel_case_to_underscore_converter.dart';
import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_field_copy_with_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_field_definitions_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_field_from_map_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_field_parameters_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_field_to_map_generator.dart';

import 'package:sqlparser/sqlparser.dart';

class TableModelGenerator extends FileGenerator {
  TableModelGenerator(this.statement);

  final Either<CreateTableStatement, String> statement;

  final String placeholderUnderscoreSqlTableName = '%underscoreSqlTableName%';
  final String placeholderTableName = '%tableName%';
  final String placeholderFields = '%fields%';
  final String placeholderConstructorParameters = '%constructorParameters%';
  final String placeholderToMap = '%toMap%';
  final String placeholderFromMap = '%fromMap%';
  final String placeholderCopyWith = '%copyWith%';

  final String targetFileName =
      'tables/%underscoreSqlTableName%/%underscoreSqlTableName%_model.dart';

  final content = '''
import '%underscoreSqlTableName%_values.dart';
import '../../utils.dart';

class %tableName% {
  %tableName%({
%constructorParameters%
  });
  
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

    final mapReplacements = [
      MapEntry(
        placeholderUnderscoreSqlTableName,
        CamelCaseToUnderscoreConverter().convert(sqlTableName),
      ),
      MapEntry(
        placeholderTableName,
        UnderscoreToCamelCaseConverter().convert(sqlTableName),
      ),
      MapEntry(
        placeholderFields,
        SourceFieldDefinitionsGenerator(createTableStatement.columns)
            .generate(),
      ),
      MapEntry(
        placeholderConstructorParameters,
        SourceFieldParametersGenerator(createTableStatement.columns).generate(),
      ),
      MapEntry(
        placeholderToMap,
        SourceFieldToMapGenerator(
          createTableStatement.tableName,
          createTableStatement.columns,
        ).generate(),
      ),
      MapEntry(
        placeholderFromMap,
        SourceFieldFromMapGenerator(
          createTableStatement.tableName,
          createTableStatement.columns,
        ).generate(),
      ),
      MapEntry(
        placeholderCopyWith,
        SourceFieldCopyWithGenerator(
          createTableStatement.tableName,
          createTableStatement.columns,
        ).generate(),
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
