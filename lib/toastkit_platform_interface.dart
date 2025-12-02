import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'toastkit_method_channel.dart';

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

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
