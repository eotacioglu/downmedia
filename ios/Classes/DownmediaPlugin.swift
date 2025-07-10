// import Flutter
// import UIKit
//
// public class DownmediaPlugin: NSObject, FlutterPlugin {
//   public static func register(with registrar: FlutterPluginRegistrar) {
//     let channel = FlutterMethodChannel(name: "downmedia", binaryMessenger: registrar.messenger())
//     let instance = DownmediaPlugin()
//     registrar.addMethodCallDelegate(instance, channel: channel)
//   }
//
//   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//     switch call.method {
//     case "getPlatformVersion":
//       result("iOS " + UIDevice.current.systemVersion)
//     default:
//       result(FlutterMethodNotImplemented)
//     }
//   }
// }


// import Flutter
// import UIKit
//
// public class DownmediaPlugin: NSObject, FlutterPlugin {
//   public static func register(with registrar: FlutterPluginRegistrar) {
//     let channel = FlutterMethodChannel(name: "downmedia", binaryMessenger: registrar.messenger())
//     let instance = DownmediaPlugin()
//     registrar.addMethodCallDelegate(instance, channel: channel)
//   }
//
//   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//     switch call.method {
//     case "getPlatformVersion":
//       result("iOS " + UIDevice.current.systemVersion)
//
//     case "downMedia":
//       guard let args = call.arguments as? [String: Any],
//             let mediaName = args["mediaName"] as? String,
//             let data = args["data"] as? FlutterStandardTypedData else {
//         result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
//         return
//       }
//
//       let bytes = data.data
//       let fileManager = FileManager.default
//
//       do {
//         let urls = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask)
//         let downloadUrl = urls.first ?? fileManager.temporaryDirectory
//         let fileUrl = downloadUrl.appendingPathComponent(mediaName)
//
//         try bytes.write(to: fileUrl)
//         result("Saved to: \(fileUrl.path)")
//       } catch {
//         result(FlutterError(code: "WRITE_ERROR", message: "Failed to write file", details: error.localizedDescription))
//       }
//
//     default:
//       result(FlutterMethodNotImplemented)
//     }
//   }
// }




// import Flutter
// import UIKit
//
// public class DownmediaPlugin: NSObject, FlutterPlugin {
//   public static func register(with registrar: FlutterPluginRegistrar) {
//     let channel = FlutterMethodChannel(name: "downmedia", binaryMessenger: registrar.messenger())
//     let instance = DownmediaPlugin()
//     registrar.addMethodCallDelegate(instance, channel: channel)
//   }
//
// public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//   switch call.method {
//   case "downMedia":
//     guard let args = call.arguments as? [String: Any],
//           let data = args["data"] as? FlutterStandardTypedData,
//           let mediaName = args["mediaName"] as? String else {
//       result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
//       return
//     }
//
//     // Burada data.data ile ByteData alırsın
//     let bytes = data.data
//
//     // Dosya yazma işlemi
//     let fileManager = FileManager.default
//     let tempDir = NSTemporaryDirectory()
//     let filePath = (tempDir as NSString).appendingPathComponent(mediaName)
//
//     do {
//       try bytes.write(to: URL(fileURLWithPath: filePath))
//       // İstersen burada paylaş veya başka işlemler yapabilirsin
//       result(nil)
//     } catch {
//       result(FlutterError(code: "WRITE_ERROR", message: "Failed to write file: \(error.localizedDescription)", details: nil))
//     }
//
//   default:
//     result(FlutterMethodNotImplemented)
//   }
// }
//
// }


import Flutter
import UIKit

public class DownmediaPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "downmedia", binaryMessenger: registrar.messenger())
    let instance = DownmediaPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)

    case "downMedia":
      guard let args = call.arguments as? [String: Any],
            let data = args["data"] as? FlutterStandardTypedData,
            let mediaName = args["mediaName"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
        return
      }

      let bytes = data.data

      // Dosyayı temp dizine kaydet
      let fileManager = FileManager.default
      let tempDir = NSTemporaryDirectory()
      let filePath = (tempDir as NSString).appendingPathComponent(mediaName)
      let fileUrl = URL(fileURLWithPath: filePath)

      do {
        try bytes.write(to: fileUrl)

        // İstersen burada dosyayı paylaşabilirsin:
        DispatchQueue.main.async {
          let controller = UIApplication.shared.windows.first?.rootViewController
          let activityVC = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
          controller?.present(activityVC, animated: true)
        }

        result(nil)
      } catch {
        result(FlutterError(code: "WRITE_ERROR", message: "Failed to write file: \(error.localizedDescription)", details: nil))
      }

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
