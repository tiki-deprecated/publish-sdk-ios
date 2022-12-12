import Flutter
import FlutterPluginRegistrant

public class TikiSdkFlutterChannel {

    let channelId = "tiki_sdk_flutter"
    
    var flutterEngine: FlutterEngine
    
    public var tikiSdk: TikiSdk?
    public var methodChannel: FlutterMethodChannel

    public init(apiId: String, origin: String) {
        flutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine);
        methodChannel = FlutterMethodChannel.init(name: channelId, binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
        methodChannel.setMethodCallHandler(handle)
        methodChannel.invokeMethod(
            "build", arguments: [
                "apiId" : apiId,
                "origin" : origin,
                "requestId" : "build"
            ]
        )
    }
    
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
                tikiSdk!.completions[requestId]?(true, response)
            break
            case "error" :
                tikiSdk!.completions[requestId]?(false, response)
            break
            default :
                result(FlutterError(code: "-1", message: "Uninplemented", details: call.arguments))
        }
    }

}
