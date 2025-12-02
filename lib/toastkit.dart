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

  static Future showInfoWithText(String text) {
    return ToastkitPlatform.instance.showInfoWithText(text);
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
