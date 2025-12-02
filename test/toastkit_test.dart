import 'package:flutter_test/flutter_test.dart';
import 'package:toastkit/toastkit.dart';
import 'package:toastkit/toastkit_platform_interface.dart';
import 'package:toastkit/toastkit_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockToastkitPlatform
    with MockPlatformInterfaceMixin
    implements ToastkitPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ToastkitPlatform initialPlatform = ToastkitPlatform.instance;

  test('$MethodChannelToastkit is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelToastkit>());
  });

  test('getPlatformVersion', () async {
    Toastkit toastkitPlugin = Toastkit();
    MockToastkitPlatform fakePlatform = MockToastkitPlatform();
    ToastkitPlatform.instance = fakePlatform;

    expect(await toastkitPlugin.getPlatformVersion(), '42');
  });
}
