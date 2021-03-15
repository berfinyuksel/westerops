import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension MediaQueryExtension on BuildContext {
  double get height => mediaQuery.size.height;
  double get width => mediaQuery.size.width;

  double dynamicHeight(double multiplier) {
    return mediaQuery.size.height * multiplier;
  }

  double dynamicWidht(double multiplier) {
    return mediaQuery.size.width * multiplier;
  }
}
