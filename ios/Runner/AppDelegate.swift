import UIKit
import Flutter
import GoogleMaps
import Braintree



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyCHKdl_iQNomnmj7Lm8x3WYBbQPeqRBNLo")
    BTAppSwitch.setReturnURLScheme("sb-vomui5462223@business.example.com")

    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
      if url.scheme == "sb-vomui5462223@business.example.com" {
          return BTAppSwitch.handleOpen(url, options:options)
      }
      
      return false
  }
}
