//package com.odiapp.downmedia.downmedia
//
//import androidx.annotation.NonNull
//
//import io.flutter.embedding.engine.plugins.FlutterPlugin
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.common.MethodChannel.MethodCallHandler
//import io.flutter.plugin.common.MethodChannel.Result
//
///** DownmediaPlugin */
//class DownmediaPlugin: FlutterPlugin, MethodCallHandler {
//  /// The MethodChannel that will the communication between Flutter and native Android
//  ///
//  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
//  /// when the Flutter Engine is detached from the Activity
//  private lateinit var channel : MethodChannel
//
//  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "downmedia")
//    channel.setMethodCallHandler(this)
//  }
//
//  override fun onMethodCall(call: MethodCall, result: Result) {
//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }
//  }
//
//  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
//    channel.setMethodCallHandler(null)
//  }
//}
package com.odiapp.downmedia

import android.content.Context
import android.os.Environment
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class DownmediaPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "downmedia")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "downMedia" -> {
                val arguments = call.arguments as? Map<String, Any>
                if (arguments == null) {
                    result.error("INVALID_ARGUMENTS", "Arguments are null", null)
                    return
                }

                val mediaName = arguments["mediaName"] as? String
                val data = arguments["data"] as? ByteArray

                if (mediaName == null || data == null) {
                    result.error("INVALID_ARGUMENTS", "mediaName or data is null", null)
                    return
                }

                try {
                    // Dışarıdaki Download klasörü, Android 10+ için izin gerekebilir
                    val downloadsDir =
                        Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
                    val file = File(downloadsDir, mediaName)
                    val fos = FileOutputStream(file)
                    fos.write(data)
                    fos.close()

                    result.success("Saved to: ${file.absolutePath}")
                } catch (e: Exception) {
                    result.error("WRITE_ERROR", "Failed to write file: ${e.localizedMessage}", null)
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
