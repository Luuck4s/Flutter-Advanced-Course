

// extesion on String

import 'package:flutter_advanced_course/data/mapper/mapper.dart';

extension NonNullString on String?{
  String orEmpty(){
    if(this == null){
      return EMPTY;
    }
    else {
      return this!;
    }
  }
}


// extesion on Integer

extension NonNullInteger on int?{
  int orZero(){
    if(this == null){
      return ZERO;
    }
    else {
      return this!;
    }
  }
}