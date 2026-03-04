import 'toastkit_platform_interface.dart';

export 'toastkit_platform_interface.dart' show ToastMode, ToastMaskMode, ToastAnimationMode;

/// Toast 原生弹窗 API，跨平台（iOS/Android/Web）。
class Toastkit {
  /// 初始化 HUD 样式（风格、遮罩、动画），建议在应用启动时调用一次。
  static void init({
    ToastMode mode = ToastMode.light,
    ToastMaskMode maskMode = ToastMaskMode.none,
    ToastAnimationMode animationMode = ToastAnimationMode.flat,
  }) {
    ToastkitPlatform.instance.init(
      mode: mode,
      maskMode: maskMode,
      animationMode: animationMode,
    );
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
