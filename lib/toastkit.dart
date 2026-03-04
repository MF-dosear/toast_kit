import 'toastkit_platform_interface.dart';

/// Toast 原生弹窗 API，跨平台（iOS/Android/Web）。
class Toastkit {
  static void setStyle({ToastMode mode = ToastMode.light}) {
    ToastkitPlatform.instance.setStyle(mode: mode);
  }

  static void setMaskMode({ToastMaskMode mode = ToastMaskMode.none}) {
    ToastkitPlatform.instance.setMaskMode(mode: mode);
  }

  static void setAnimationMode({ToastAnimationMode mode = ToastAnimationMode.flat}) {
    ToastkitPlatform.instance.setAnimationMode(mode: mode);
  }

  static void show() {
    ToastkitPlatform.instance.show();
  }

  static Future<void> dismiss() {
    return ToastkitPlatform.instance.dismiss();
  }

  static void showProgress({double value = 0.0}) {
    ToastkitPlatform.instance.showProgress(value: value);
  }

  static Future<void> showText(String text) {
    return ToastkitPlatform.instance.showText(text);
  }

  static Future<void> showSuccessWithText(String text) {
    return ToastkitPlatform.instance.showSuccessWithText(text);
  }

  static Future<void> showWarningWithText(String text) {
    return ToastkitPlatform.instance.showWarnWithText(text);
  }

  static Future<void> showErrorWithText(String text) {
    return ToastkitPlatform.instance.showErrorWithText(text);
  }
}
