import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)


    GMSServices.provideAPIKey("AIzaSyDmbISvHTI8ohyLzmek96__1ACHqTNkPLg")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
