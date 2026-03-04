import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'toastkit_method_channel.dart';

enum ToastMode {
  /// White HUD with black text. HUD background will be blurred.
  light,

  /// Black HUD with white text. HUD background will be blurred.
  dark,

  /// Uses the fore- and background color properties.
  custom,

  /// Automatically switch between light or dark mode appearance.
  automatic,
}

enum ToastMaskMode {
  /// Allow user interactions while HUD is displayed.
  none,

  /// Don't allow user interactions with background objects.
  clear,

  /// Don't allow user interactions and dim the UI behind the HUD (as in iOS 7+).
  black,

  /// Don't allow user interactions and dim the UI with an UIAlertView-like background gradient (as in iOS 6).
  gradient,

  /// Don't allow user interactions and dim the UI behind the HUD with a custom color.
  custom,
}

enum ToastAnimationMode {
  /// Custom flat animation (indefinite animated ring).
  flat,
  
  /// iOS native UIActivityIndicatorView.
  native
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

  void setStyle({ToastMode mode = ToastMode.light}) {
    throw UnimplementedError('setDefaultStyle');
  }

  void setMaskMode({ToastMaskMode mode = ToastMaskMode.none}) {
    throw UnimplementedError('setDefaultMaskType');
  }

  void setAnimationMode({ToastAnimationMode mode = ToastAnimationMode.flat}) {
    throw UnimplementedError('setDefaultAnimationType');
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

  void showProgressWithText({double value = 0.0, String? text = 'unknown'}) {
    throw UnimplementedError('showProgressWithText');
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

  // case "dismissDelayWithCompletion":
  Future<void> dismissDelayWithCompletion(int delay) async {
    throw UnimplementedError('dismissDelayWithCompletion');
  }
}
