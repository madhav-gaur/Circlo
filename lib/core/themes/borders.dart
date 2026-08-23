import 'package:flutter/material.dart';

class AppBorders {
  static const BorderRadius small = BorderRadius.all(Radius.circular(8.0));
  
  static const BorderRadius medium = BorderRadius.all(Radius.circular(16.0));
  
  static const BorderRadius largeBottom = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  static const BorderRadius pill = BorderRadius.all(Radius.circular(99.0));
}
