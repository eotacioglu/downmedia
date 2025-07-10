// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'downmedia_platform_interface.dart';

/// A web implementation of the DownmediaPlatform of the Downmedia plugin.
class DownmediaWeb extends DownmediaPlatform {
  /// Constructs a DownmediaWeb
  DownmediaWeb();
  void downloadPdf(Uint8List pdfData) {

  }
  static void registerWith(Registrar registrar) {
    DownmediaPlatform.instance = DownmediaWeb();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }

@override
  Future<void> downMedia({Uint8List? data, required String mediaName, String? url}) async {
  final blob = html.Blob([data??[]]);
  final getUrl = url ?? html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: getUrl)
    ..setAttribute("download", mediaName) // Dosya adını belirleme
    ..style.display = 'none';

  html.document.body?.children.add(anchor);
  anchor.click();

  html.document.body?.children.remove(anchor);
  html.Url.revokeObjectUrl(getUrl);
  }
}
