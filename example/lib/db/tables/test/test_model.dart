import 'dart:typed_data';

import 'test_values.dart';
import '../../utils.dart';

class Test {
  Test({
    this.id,
    required this.text,
    required this.number,
    required this.numeric,
    required this.date,
    required this.isChecked,
    required this.anything,
  });
  
    final int? id;
    final String text;
    final int number;
    final double numeric;
    final DateTime date;
    final bool isChecked;
    final Uint8List anything;

  Map<String, Object?> toMap() {
    var map = <String, Object?> {
      testColumnText: text,
      testColumnNumber: number,
      testColumnNumeric: numeric,
      testColumnDate: date.toUtc().millisecondsSinceEpoch,
      testColumnIsChecked: boolToInt(isChecked),
      testColumnAnything: anything,
    };

    if (id != null) {
      map[testColumnId] = id;
    }
        
    return map;
  }  

  factory Test.fromMap(Map<String, Object?> map) {
    final id = map[testColumnId] as int?;
    final text = map[testColumnText] as String;
    final number = map[testColumnNumber] as int;
    final numeric = map[testColumnNumeric] as double;
    final date = DateTime.fromMillisecondsSinceEpoch(map[testColumnDate] as int, isUtc: true,);
    final isChecked = intToBool(map[testColumnIsChecked] as int);
    final anything = map[testColumnAnything] as Uint8List;

    return Test(
      id: id,
      text: text,
      number: number,
      numeric: numeric,
      date: date,
      isChecked: isChecked,
      anything: anything,
    );
  }  

  Test copyWith({
    Wrapped<int?>? id,
    String? text,
    int? number,
    double? numeric,
    DateTime? date,
    bool? isChecked,
    Uint8List? anything,
  }) {
    return Test(
      id: isNull(id) ? this.id : (id!.value),
      text: isNull(text) ? this.text : text!,
      number: isNull(number) ? this.number : number!,
      numeric: isNull(numeric) ? this.numeric : numeric!,
      date: isNull(date) ? this.date : date!,
      isChecked: isNull(isChecked) ? this.isChecked : isChecked!,
      anything: isNull(anything) ? this.anything : anything!,
    );
  }

}
