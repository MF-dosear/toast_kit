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
        case "setDefaultStyle":
            if let styleIndex = call.arguments as? Int, let style = SVProgressHUDStyle(rawValue: styleIndex) {
                QSToast.setDefaultStyle(style)
                result(true)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid style index", details: nil))
            }
        case "setDefaultMaskType":
            if let maskIndex = call.arguments as? Int, let maskType = SVProgressHUDMaskType(rawValue: UInt(maskIndex)) {
                QSToast.setDefaultMaskType(maskType)
                result(true)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid mask type index", details: nil))
            }
        case "setDefaultAnimationType":
            if let animIndex = call.arguments as? Int, let animType = SVProgressHUDAnimationType(rawValue: UInt(animIndex)) {
                QSToast.setDefaultAnimationType(animType)
                result(true)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid animation type index", details: nil))
            }
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
        case "showProgressWithText":
            guard let dict = call.arguments as? Dictionary<String, Any?> else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected a dictionary with 'value' and 'text' keys", details: nil))
                return
            }
            let value = (dict["value"] as? Double ?? 0.0)
            let text = dict["text"] as? String ?? ""
            QSToast.showProgress(Float(value), status: text)
            result(true)
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
        case "dismissDelayWithCompletion":
            // delay 参数应该是毫秒，需要转换为秒
            let delayMs = call.arguments as? Int ?? 1600
            let delay = Double(delayMs) / 1000.0
            QSToast.dismiss(withDelay: delay) {
                result(true)
            }
        default:
          result(FlutterMethodNotImplemented)
    }
  }
}
