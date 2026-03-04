// ignore: avoid_web_libraries_in_flutter

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'toastkit_platform_interface.dart';

/// Web 实现：无原生 HUD，采用 no-op，避免在 Web 上调用时崩溃。
class ToastkitWeb extends ToastkitPlatform {
  ToastkitWeb();

  static void registerWith(Registrar registrar) {
    ToastkitPlatform.instance = ToastkitWeb();
  }

  @override
  void setStyle({ToastMode mode = ToastMode.light}) {}

  @override
  void setMaskMode({ToastMaskMode mode = ToastMaskMode.none}) {}

  @override
  void setAnimationMode({ToastAnimationMode mode = ToastAnimationMode.flat}) {}

  @override
  void show() {}

  @override
  Future<void> dismiss() async {}

  @override
  void showProgress({double value = 0.0}) {}

  @override
  Future<void> showText(String text) async {}

  @override
  Future<void> showSuccessWithText(String text) async {}

  @override
  Future<void> showWarnWithText(String text) async {}

  @override
  Future<void> showErrorWithText(String text) async {}
}
