// import 'dart:typed_data';
// import 'downmedia_platform_interface.dart';
//
// class Downmedia {
//   Future<String?> getPlatformVersion() {
//     return DownmediaPlatform.instance.getPlatformVersion();
//   }
//
//   Future<void> downMedia({Uint8List? data, required String mediaName, String? url}) async {
//      DownmediaPlatform.instance.downMedia(data: data,mediaName: mediaName,url: url);
//   }
// }

import 'dart:typed_data';
import 'downmedia_platform_interface.dart';

class Downmedia {
  Future<String?> getPlatformVersion() {
    return DownmediaPlatform.instance.getPlatformVersion();
  }

  /// Main method to download media
  Future<void> downMedia({
    Uint8List? data,
    required String mediaName,
    String? url,
  }) async {
    await DownmediaPlatform.instance.downMedia(
      data: data,
      mediaName: mediaName,
      url: url,
    );
  }
}
