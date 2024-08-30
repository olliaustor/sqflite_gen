import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/CreateTableStatementExt.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/columns_to_const_definitions_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/table_to_const_create_name_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_values/source_generators/table_to_const_definition_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/table_file_name_generator.dart';

import 'package:sqlparser/sqlparser.dart';

/// Generates file containing all const values from table
class TableValuesGenerator extends FileGenerator {
  /// Creates new object for given [statement]
  TableValuesGenerator(this.statement);

  /// [statement] of table to be processed
  final Either<CreateTableStatement, String> statement;

  /// Suffix to be added to the final filename
  final String fileNameSuffix = 'values';

  /// Placeholder for const definition of table name
  final String placeholderConstTable = '%const_definition_table%';

  /// Placeholder for const definitions of all columns of table
  final String placeholderConstColumns = '%const_definition_columns%';

  /// Placeholder for plain sql create script
  final String placeholderSqlTableCreate = '%sqlTableCreate%';

  /// Placeholder for table const name
  final String placeholderTableNameCreate = '%tableNameCreate%';

  /// Placeholder for sql definitions of all columns of table
  final String placeholderColumnDefinitions = '%column_definitions%';

  /// Content of file (including placeholder(s))
  final String content = '''
%const_definition_table%
%const_definition_columns%

const String %tableNameCreate% = \'\'\'
%sqlTableCreate%
\'\'\';
''';

  @override
  Future<FileGeneratorResult> generate() async {
    final createTableStatement = statement.asLeft() as CreateTableStatementExt;
    final sqlTableName = createTableStatement.tableName;

    final mapReplacements = [
      /// Const definition of table name
      MapEntry(
        placeholderConstTable,
        TableToConstDefinitionGenerator()(createTableStatement),
      ),

      /// Const definitions of all columns
      MapEntry(
        placeholderConstColumns,
        ColumnsToConstDefinitionsGenerator()(createTableStatement),
      ),

      /// Const name of create statement
      MapEntry(
        placeholderTableNameCreate,
        TableToConstCreateNameGenerator()(createTableStatement),
      ),

      /// Plain sql create script
      MapEntry(
        placeholderSqlTableCreate,
        createTableStatement.createSqlStatement,
      ),
    ];

    final fileContent = content.replaceAllFromList(
      mapReplacements,
    );

    final fullFileName = TableFileNameGenerator()(
      createTableStatement,
      fileNameSuffix: fileNameSuffix,
    );

    return FileGeneratorResult(
      targetFileName: fullFileName,
      content: fileContent,
    );
  }
}
