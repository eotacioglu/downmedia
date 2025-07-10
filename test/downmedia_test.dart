import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:downmedia/downmedia.dart';
import 'package:downmedia/downmedia_platform_interface.dart';
import 'package:downmedia/downmedia_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDownmediaPlatform
    with MockPlatformInterfaceMixin
    implements DownmediaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

@override
  Future<void> downMedia({Uint8List? data, required String mediaName, String? url}) {
    throw UnimplementedError();
  }
}

void main() {
  final DownmediaPlatform initialPlatform = DownmediaPlatform.instance;

  test('$MethodChannelDownmedia is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDownmedia>());
  });

  test('getPlatformVersion', () async {
    Downmedia downmediaPlugin = Downmedia();
    MockDownmediaPlatform fakePlatform = MockDownmediaPlatform();
    DownmediaPlatform.instance = fakePlatform;

    expect(await downmediaPlugin.getPlatformVersion(), '42');
  });
}
