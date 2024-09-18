import 'package:fpdart/fpdart.dart';
import 'package:sqflite_gen/src/converters/camel_case_to_underscore_converter.dart';
import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/converters/table_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/extensions/create_table_statement_extensions.dart';
import 'package:sqflite_gen/src/extensions/either_extensions.dart';
import 'package:sqflite_gen/src/extensions/string_extensions.dart';
import 'package:sqflite_gen/src/generators/file_generators/file_generator_base.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/constructor/table_to_constructor_generator.dart';
import 'package:sqflite_gen/src/generators/file_generators/table_provider/source_generator/create/table_to_method_create_generator.dart';
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

  final String placeholderUnderscoreSqlTableName = '%underscoreSqlTableName%';
  final String placeholderClassName = '%className%';
  final String placeholderFieldName = '%fieldName%';
  final String placeholderFileName = '%fileName%';
  final String placeholderTableNameConst = '%tableNameConst%';
  final String placeholderPrimaryColumnNameConst = '%primaryColumnNameConst%';
  final String placeholderPrimaryColumnFieldName = '%primaryColumnFieldName%';

  final String targetFileName =
      'tables/%underscoreSqlTableName%/%underscoreSqlTableName%_provider.dart';

  final content = '''
import '../../generic_provider.dart';
import '%fileName%_model.dart';
import '%fileName%_values.dart';
import 'package:sqflite/sqflite.dart';

class %className%Provider {
%constructor%

  final Database db;

%create%

  @override
  Future<%className%> insert(%className% %fieldName%) async {
    final result = await db.insert(%tableNameConst%, %fieldName%.toMap());
       
    return %fieldName%.copyWith(%primaryColumnFieldName%: result);
  }

  @override
  Future<%className%?> get(int %primaryColumnFieldName%) async {
    final maps = await db.query(%tableNameConst%,
      where: '\$%primaryColumnNameConst% = ?',
      whereArgs: [%primaryColumnFieldName%],);

    if (maps.isNotEmpty) {
      return %className%.fromMap(maps.first);
    }

    return null;
  }

  @override
  Future<int> delete(int %primaryColumnFieldName%) async {
    return db.delete(%tableNameConst%,
      where: '\$%primaryColumnNameConst% = ?',
      whereArgs: [%primaryColumnFieldName%],);
  }

  @override
  Future<int> update(%className% %fieldName%) async {
    return db.update(%tableNameConst%, %fieldName%.toMap(),
      where: '\$%primaryColumnNameConst% = ?',
      whereArgs: [%fieldName%.%primaryColumnFieldName%],);
  }
}
''';

  @override
  Future<FileGeneratorResult> generate() async {
    final createTableStatement = statement.asLeft();
    final sqlTableName = createTableStatement.tableName;

    final fileNameGenerator = TableFileNameGenerator();
    final constructorGenerator = TableToConstructorGenerator();
    final createGenerator = TableToMethodCreateGenerator();

    final fullFileName = TableFileNameGenerator()(
      createTableStatement,
      fileNameSuffix: fileNameSuffix,
    );

    final mapReplacements = [
      MapEntry(
        placeholderUnderscoreSqlTableName,
        CamelCaseToUnderscoreConverter().convert(sqlTableName),
      ),
      MapEntry(
        placeholderFieldName,
        createTableStatement.toFieldName(),
      ),
      MapEntry(
        placeholderFileName,
        createTableStatement.toFileName(),
      ),
      MapEntry(
        placeholderTableNameConst,
        TableNameToConstNameConverter().convert(sqlTableName),
      ),
      MapEntry(
        placeholderPrimaryColumnNameConst,
          _getPrimaryColumnNameConst(sqlTableName, createTableStatement.columns),
      ),
      MapEntry(
        placeholderPrimaryColumnFieldName,
        _getPrimaryColumnNameField(sqlTableName, createTableStatement.columns),
      ),
    ];

    final fileContent = content
        .replaceAll(placeholderClassName, createTableStatement.toClassName())
        .replaceAll(placeholderConstructor,
      constructorGenerator(createTableStatement),)
        .replaceAll(placeholderCreate,
      createGenerator(createTableStatement),)

        .replaceAllFromList(mapReplacements);

    return FileGeneratorResult(
      targetFileName: fullFileName,
      content: fileContent,
    );
  }

  String _getPrimaryColumnNameConst(String tableName, List<ColumnDefinition> columns) {
    final primaryKeyColumn = columns
        .where((column) => column.isPrimaryKey()).firstOrNull;

    return primaryKeyColumn == null
        ? 'unknown'
        : ColumnNameToConstNameConverter(tableName)
            .convert(primaryKeyColumn.columnName);
  }

  String _getPrimaryColumnNameField(String tableName, List<ColumnDefinition> columns) {
    final primaryKeyColumn = columns
        .where((column) => column.isPrimaryKey()).firstOrNull;

    return primaryKeyColumn == null
        ? 'unknown'
        : primaryKeyColumn.toFieldName();
  }
}
