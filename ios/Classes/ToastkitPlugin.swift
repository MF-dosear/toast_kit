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
            QSToast.setDefaultStyle(SVProgressHUDStyle(rawValue: call.arguments as? Int ?? 0) ?? .light)
        case "setDefaultMaskType":
            QSToast.setDefaultMaskType(SVProgressHUDMaskType(rawValue: call.arguments as? UInt ?? 0) ?? .none)
        case "setDefaultAnimationType":
            QSToast.setDefaultAnimationType(SVProgressHUDAnimationType(rawValue: call.arguments as? UInt ?? 0) ?? .flat)
        case "show":
            QSToast.show()
        case "dismiss":
            QSToast.dismiss {
                result(true)
            }
        case "showProgres":
            QSToast.showProgres(call.arguments as? Float ?? 0)
        case "showProgresWithText":
        guard let dict = call.arguments as? Dictionary<String, Any?> else { return }
            QSToast.showProgres(dict["value"] as? Float ?? 0, text: dict["text"] as? String ?? "")
        case "showText":
            QSToast.showText(call.arguments as? String ?? "") {
                result(true)
            }
        case "showSuccessWithText":
            QSToast.showSuccess(withText: call.arguments as? String ?? "") {
                result(true)
            }
        case "showWarnWithText":
            QSToast.showWarn(withText: call.arguments as? String ?? "") {
                result(true)
            }
        case "showErrorWithText":
            QSToast.showError(withText: call.arguments as? String ?? "") {
                result(true)
            }
        case "dismissDelayWithCompletion":
            QSToast.dismissDelay(completion: {
                result(true)
            })
        default:
          result(FlutterMethodNotImplemented)
    }
  }
}
