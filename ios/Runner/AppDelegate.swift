import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Setup Live Activity channel
    if #available(iOS 16.1, *) {
      let controller = window?.rootViewController as! FlutterViewController
      let liveActivityChannel = FlutterMethodChannel(
        name: "com.packard.stopwatch/live_activity",
        binaryMessenger: controller.binaryMessenger
      )
      
      liveActivityChannel.setMethodCallHandler { (call, result) in
        switch call.method {
        case "startLiveActivity":
          if let args = call.arguments as? [String: Any],
             let elapsedTime = args["elapsedTime"] as? Double,
             let isRunning = args["isRunning"] as? Bool {
            LiveActivityManager.shared.startLiveActivity(elapsedTime: elapsedTime, isRunning: isRunning)
            result(nil)
          } else {
            result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
          }
        case "updateLiveActivity":
          if let args = call.arguments as? [String: Any],
             let elapsedTime = args["elapsedTime"] as? Double,
             let isRunning = args["isRunning"] as? Bool {
            LiveActivityManager.shared.updateLiveActivity(elapsedTime: elapsedTime, isRunning: isRunning)
            result(nil)
          } else {
            result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
          }
        case "endLiveActivity":
          LiveActivityManager.shared.endLiveActivity()
          result(nil)
        default:
          result(FlutterMethodNotImplemented)
        }
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
