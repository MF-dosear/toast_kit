
import 'toastkit_platform_interface.dart';

class Toastkit {
  Future<String?> getPlatformVersion() {
    return ToastkitPlatform.instance.getPlatformVersion();
  }
}
