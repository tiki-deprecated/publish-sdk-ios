import Flutter
import FlutterPluginRegistrant

public class TikiSdkFlutterChannel {

    let channelId = "tiki_sdk_flutter"
    
    var flutterEngine: FlutterEngine
    
    public var tikiSdk: TikiSdk?
    public var methodChannel: FlutterMethodChannel

    /// Initializes the Flutter Engine and Platform Channels and builds the Dart SDK.
    public init(apiId: String, origin: String, address : String? = nil) {
        flutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine);
        methodChannel = FlutterMethodChannel.init(name: channelId, binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
        methodChannel.setMethodCallHandler(handle)
        methodChannel.invokeMethod(
            "build", arguments: [
                "apiId" : apiId,
                "origin" : origin,
                "address" : address,
                "requestId" : "build"
            ]
        )
    }
    
    /// Handles the method calls from Flutter.
    ///
    /// When calling TIKI SDK Flutter from native code, one should pass a requestId
    /// that will identify to which request the response belongs to.
    /// All the calls are asynchronous and should be treated like this.
    public func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let requestId = (call.arguments as? Dictionary<String, Any>)?["requestId"] as? String else {
            result(FlutterError.init(code: "-1", message: "missing requestId argument", details: call.arguments))
            return
        }
        let response = (call.arguments as? Dictionary<String, Any>)?["response"] as? String
        switch (call.method) {
            case "success" :
                if(requestId == "build"){
                    tikiSdk!.address = response!
                }
                tikiSdk!.continuations[requestId]?.resume(returning: response!)
            break
            case "error" :
                tikiSdk!.continuations[requestId]?.resume(throwing: TikiSdkError(message: response))
            break
            default :
                result(FlutterError(code: "-1", message: "Uninplemented", details: call.arguments))
                tikiSdk!.continuations[requestId]?.resume(throwing: TikiSdkError(message: "Uninplemented method"))
        }
    }

}
