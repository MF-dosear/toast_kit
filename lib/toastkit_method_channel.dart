import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'toastkit_platform_interface.dart';

/// An implementation of [ToastkitPlatform] that uses method channels.
class MethodChannelToastkit extends ToastkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('toastkit');

  @override
  void init({
    ToastMode mode = ToastMode.light,
    ToastMaskMode maskMode = ToastMaskMode.none,
    ToastAnimationMode animationMode = ToastAnimationMode.flat,
  }) {
    methodChannel.invokeMethod('init', {
      'style': mode.index,
      'maskType': maskMode.index,
      'animationType': animationMode.index,
    });
  }

  @override
  void show() {
    methodChannel.invokeMethod('show');
  }

  // case "dismiss":
  @override
  Future<void> dismiss() async {
    await methodChannel.invokeMethod('dismiss');
  }

  @override
  void showProgress({double value = 0.0}) {
    methodChannel.invokeMethod('showProgress', value);
  }

  @override
  Future<void> showText(String text) async {
    await methodChannel.invokeMethod('showText', text);
  }

  @override
  Future<void> showSuccessWithText(String text) async {
    await methodChannel.invokeMethod('showSuccessWithText', text);
  }

  @override
  Future<void> showWarnWithText(String text) async {
    await methodChannel.invokeMethod('showWarnWithText', text);
  }

  @override
  Future<void> showErrorWithText(String text) async {
    await methodChannel.invokeMethod('showErrorWithText', text);
  }
}
