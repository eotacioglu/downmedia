import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'downmedia_platform_interface.dart';

/// An implementation of [DownmediaPlatform] that uses method channels.
class MethodChannelDownmedia extends DownmediaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('downmedia');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

@override
  Future<void> downMedia({ Uint8List? data, required String mediaName, String? url}) async {
  methodChannel.invokeMethod('downMedia',[data,mediaName,url]);

  }

}
