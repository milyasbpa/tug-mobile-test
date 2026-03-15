import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;

  static const BorderRadius noneBorderRadius = BorderRadius.zero;
  static const BorderRadius xsBorderRadius =
      BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smBorderRadius =
      BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdBorderRadius =
      BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgBorderRadius =
      BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlBorderRadius =
      BorderRadius.all(Radius.circular(xl));
  static const BorderRadius fullBorderRadius =
      BorderRadius.all(Radius.circular(full));
}
