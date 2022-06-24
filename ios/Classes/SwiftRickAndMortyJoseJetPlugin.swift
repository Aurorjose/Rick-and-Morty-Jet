import Flutter
import UIKit

public class SwiftRickAndMortyJoseJetPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "rick_and_morty_jose_jet", binaryMessenger: registrar.messenger())
    let instance = SwiftRickAndMortyJoseJetPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
