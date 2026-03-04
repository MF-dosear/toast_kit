import Flutter
import UIKit
import SVProgressHUD

public class ToastkitPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "toastkit", binaryMessenger: registrar.messenger())
    let instance = ToastkitPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "init":
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected a map with style, maskType, animationType", details: nil))
                return
            }
            let styleIndex = args["style"] as? Int ?? 0
            let maskIndex = args["maskType"] as? Int ?? 0
            let animIndex = args["animationType"] as? Int ?? 0
            if let style = SVProgressHUDStyle(rawValue: styleIndex) {
                QSToast.setDefaultStyle(style)
            }
            if let maskType = SVProgressHUDMaskType(rawValue: UInt(maskIndex) + 1) {
                QSToast.setDefaultMaskType(maskType)
            }
            if let animType = SVProgressHUDAnimationType(rawValue: UInt(animIndex)) {
                QSToast.setDefaultAnimationType(animType)
            }
            result(true)
        case "show":
            QSToast.show()
            result(true)
        case "dismiss":
            QSToast.dismiss {
                result(true)
            }
        case "showProgress":
            if let value = call.arguments as? Double {
                QSToast.showProgress(Float(value))
                result(true)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected a number for progress value", details: nil))
            }
        case "showText":
            let text = call.arguments as? String ?? ""
            QSToast.showText(text) {
                result(true)
            }
        case "showSuccessWithText":
            let text = call.arguments as? String ?? ""
            QSToast.showSuccess(withText: text) {
                result(true)
            }
        case "showWarnWithText":
            let text = call.arguments as? String ?? ""
            QSToast.showWarn(withText: text) {
                result(true)
            }
        case "showErrorWithText":
            let text = call.arguments as? String ?? ""
            QSToast.showError(withText: text) {
                result(true)
            }
        default:
          result(FlutterMethodNotImplemented)
    }
  }
}
