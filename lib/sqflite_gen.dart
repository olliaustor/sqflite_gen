/// Declaration of library
library sqflite_gen;

import 'package:build/build.dart';
import 'package:sqflite_gen/src/sqflite_dart_code_generator.dart';

///Returns instance of SwaggerDartCodeGenerator
SqfliteDartCodeGenerator sqflitegenCodeBuilder(BuilderOptions options) =>
    SqfliteDartCodeGenerator(options);

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
