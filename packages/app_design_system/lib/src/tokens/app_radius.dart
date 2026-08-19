import 'package:flutter/widgets.dart';

/// 모서리 라운드 토큰.
abstract final class AppRadius {
  static const BorderRadius sm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius md = BorderRadius.all(Radius.circular(12));
  static const BorderRadius lg = BorderRadius.all(Radius.circular(16));
}
