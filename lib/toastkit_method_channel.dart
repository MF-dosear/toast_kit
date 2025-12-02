import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'toastkit_platform_interface.dart';

/// An implementation of [ToastkitPlatform] that uses method channels.
class MethodChannelToastkit extends ToastkitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('toastkit');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
