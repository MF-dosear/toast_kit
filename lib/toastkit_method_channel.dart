import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'toastkit_platform_interface.dart';

/// An implementation of [ToastkitPlatform] that uses method channels.
class MethodChannelToastkit extends ToastkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('toastkit');

  @override
  setStyle({ToastMode mode = ToastMode.light}) {
    methodChannel.invokeMethod('setDefaultStyle', mode.index);
  }

  @override
  setMaskMode({ToastMaskMode mode = ToastMaskMode.none}) {
    methodChannel.invokeMethod('setDefaultMaskType', mode.index);
  }

  @override
  setAnimationMode({ToastAnimationMode mode = ToastAnimationMode.flat}) {
    methodChannel.invokeMethod('setDefaultAnimationType', mode.index);
  }

  // case "show":
  @override
  show() {
    methodChannel.invokeMethod('show');
  }

  // case "dismiss":
  @override
  dismiss() {
    methodChannel.invokeMethod('dismiss');
  }

  // case "showInfoWithText"
  @override
  Future showInfoWithText(String text) async {
    await methodChannel.invokeMethod('showInfoWithText', text);
  }

  // case "showSuccessWithText":
  @override
  Future showSuccessWithText(String text) async {
    await methodChannel.invokeMethod('showSuccessWithText', text);
  }

  // case "showWarnWithText":
  @override
  Future showWarnWithText(String text) async {
    await methodChannel.invokeMethod('showWarnWithText', text);
  }

  // case "showErrorWithText":
  @override
  Future showErrorWithText(String text) async {
    await methodChannel.invokeMethod('showErrorWithText', text);
  }

  // case "dismissDelayWithCompletion":
  @override
  Future dismissDelayWithCompletion(int delay) async {
    await methodChannel.invokeMethod('dismissDelayWithCompletion', delay);
  }
}
