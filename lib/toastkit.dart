import 'toastkit_platform_interface.dart';

class Toastkit {
  
  static setStyle({ToastMode mode = ToastMode.light}) {
    ToastkitPlatform.instance.setStyle(mode: mode);
  }

  static setMaskMode({ToastMaskMode mode = ToastMaskMode.none}) {
    ToastkitPlatform.instance.setMaskMode(mode: mode);
  }

  static setAnimationMode({ToastAnimationMode mode = ToastAnimationMode.flat}) {
    ToastkitPlatform.instance.setAnimationMode(mode: mode);
  }

  static show() {
    ToastkitPlatform.instance.show();
  }

  static dismiss() {
    ToastkitPlatform.instance.dismiss();
  }

  static Future showProgress({double value = 0.0}) {
    return ToastkitPlatform.instance.showProgress(value: value);
  }

  static Future showProgressWithText({double value = 0.0, String? text = 'unknown'}) {
    return ToastkitPlatform.instance.showProgressWithText(value: value, text: text);
  }

  static Future showText(String text) {
    return ToastkitPlatform.instance.showText(text);
  }

  static Future showSuccessWithText(String text) {
    return ToastkitPlatform.instance.showSuccessWithText(text);
  }

  static Future showWarningWithText(String text) {
    return ToastkitPlatform.instance.showWarnWithText(text);
  }

  static Future showErrorWithText(String text) {
    return ToastkitPlatform.instance.showErrorWithText(text);
  }

  static Future dismissDelayWithCompletion(int delay) {
    return ToastkitPlatform.instance.dismissDelayWithCompletion(delay);
  }
}
