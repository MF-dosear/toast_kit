import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'toastkit_method_channel.dart';

enum ToastMode {
  /// 浅色：白底黑字，HUD 背景模糊。
  light,

  /// 深色：黑底白字，HUD 背景模糊。
  dark,

  /// 自定义前景色与背景色。
  custom,

  /// 随系统自动切换浅色/深色。
  automatic,
}

enum ToastMaskMode {
  /// 不遮罩，HUD 显示时仍可操作背后界面。
  none,

  /// 不遮罩但禁止背后操作。
  clear,

  /// 背后半透明黑色遮罩（类似 iOS 7+）。
  black,

  /// 背后渐变遮罩（类似 iOS 6 的 UIAlertView 风格）。
  gradient,

  /// 背后使用自定义颜色的遮罩。
  custom,
}

enum ToastAnimationMode {
  /// 自定义扁平动画（无限旋转圆环）。
  flat,

  /// 使用系统原生 UIActivityIndicatorView。
  native,
}

abstract class ToastkitPlatform extends PlatformInterface {
  /// Constructs a ToastkitPlatform.
  ToastkitPlatform() : super(token: _token);

  static final Object _token = Object();

  static ToastkitPlatform _instance = MethodChannelToastkit();

  /// The default instance of [ToastkitPlatform] to use.
  ///
  /// Defaults to [MethodChannelToastkit].
  static ToastkitPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ToastkitPlatform] when
  /// they register themselves.
  static set instance(ToastkitPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 初始化 HUD 样式（风格、遮罩、动画）。
  void init({
    ToastMode mode = ToastMode.light,
    ToastMaskMode maskMode = ToastMaskMode.none,
    ToastAnimationMode animationMode = ToastAnimationMode.flat,
  }) {
    throw UnimplementedError('init');
  }

  void show() {
    throw UnimplementedError('show');
  }

  // case "dismiss":
  Future<void> dismiss() async {
    throw UnimplementedError('dismiss');
  }

  void showProgress({double value = 0.0}) {
    throw UnimplementedError('showProgress');
  }

  // case "showText":
  Future<void> showText(String text) async {
    throw UnimplementedError('showText');
  }

  // case "showSuccessWithText":
  Future<void> showSuccessWithText(String text) async {
    throw UnimplementedError('showSuccessWithText');
  }

  // case "showWarnWithText":
  Future<void> showWarnWithText(String text) async {
    throw UnimplementedError('showWarnWithText');
  }

  // case "showErrorWithText":
  Future<void> showErrorWithText(String text) async {
    throw UnimplementedError('showErrorWithText');
  }

}
