import 'package:sqflite_gen/src/converters/column_name_to_const_name_converter.dart';
import 'package:sqflite_gen/src/converters/underscore_to_camel_case_converter.dart';
import 'package:sqflite_gen/src/extensions/column_definition_extensions.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_column_to_to_map_assignment_generator.dart';
import 'package:sqflite_gen/src/generators/source_generators/source_generator_base.dart';
import 'package:sqlparser/sqlparser.dart';

// https://github.com/tekartik/sqflite/blob/master/sqflite/README.md

class SourceFieldCopyWithGenerator extends SourceGenerator {
  SourceFieldCopyWithGenerator(
      this.sqlTableName, List<ColumnDefinition> this.columnDefinitions) {}

  final List<ColumnDefinition> columnDefinitions;
  final String sqlTableName;

  final placeholderAssignments = '%assignments%';
  final placeholderParameters = '%parameters%';
  final placeholderTableName = '%tableName%';

  final content = '''
  %tableName% copyWith({
%parameters%
  }) {
    return %tableName%(
%assignments%    
    );
  }  
''';

  @override
  String generate() {
    return content
        .replaceAll(
      placeholderParameters,
      _getParameters(),
    )
        .replaceAll(
          placeholderAssignments,
      _getAssignments(),
        )
        .replaceAll(
      placeholderTableName,
          UnderscoreToCamelCaseConverter().convert(sqlTableName),
        );
  }

  String _getParameters() {
    final sb = StringBuffer();
    for (final columnDefinition in columnDefinitions) {
      var fieldType = columnDefinition.toFieldType();
      if (!fieldType.endsWith('?')) fieldType += '?';
      sb.writeln('       ${_getParameter(columnDefinition)},');
    }

    return sb.toString().trimRight();
  }

  String _getAssignments() {
    final sb = StringBuffer();
    for (final columnDefinition in columnDefinitions) {
      sb.writeln('      ${columnDefinition.toFieldName()}: ${_getAssignment(columnDefinition)},');
    }

    return sb.toString().trimRight();
  }

  String _getParameter(ColumnDefinition columnDefinition) {
    final fieldName = columnDefinition.toFieldName();
    var fieldType = columnDefinition.toFieldType();
    if (!columnDefinition.isNonNullable) {
      fieldType = 'Wrapped<$fieldType>?';
    }
    if (!fieldType.endsWith('?')) fieldType += '?';
    return '$fieldType $fieldName';
  }

  String _getAssignment(ColumnDefinition columnDefinition) {
    final fieldName = columnDefinition.toFieldName();
    if (columnDefinition.isNonNullable) {
      return 'isNull(${fieldName}) ? this.${fieldName} : ${fieldName}!';
    }

    return 'isNull(${fieldName}) ? this.${fieldName} : (${fieldName}!.value)';
  }
}
