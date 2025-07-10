import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'downmedia_method_channel.dart';

abstract class DownmediaPlatform extends PlatformInterface {
  /// Constructs a DownmediaPlatform.
  DownmediaPlatform() : super(token: _token);

  static final Object _token = Object();

  static DownmediaPlatform _instance = MethodChannelDownmedia();

  /// The default instance of [DownmediaPlatform] to use.
  ///
  /// Defaults to [MethodChannelDownmedia].
  static DownmediaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DownmediaPlatform] when
  /// they register themselves.
  static set instance(DownmediaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> downMedia(
      {Uint8List? data, required String mediaName, String? url}) async {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

}
