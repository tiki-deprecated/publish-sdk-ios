import Flutter
import FlutterPluginRegistrant

public class TikiSdkFlutterChannel {

    let channelId = "tiki_sdk_flutter"
    var flutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
    public var tikiSdk: TikiSdk?
    
    public var methodChannel: FlutterMethodChannel? = nil

    public init(apiKey: String? =  nil, origin: String? = nil) {
        if(methodChannel == nil){
            setupChannel(apiKey: apiKey ?? "", origin: origin ?? "")
        }
    }
    
    @objc(handleMethodCall:result:) public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let requestId = (call.arguments as? Dictionary<String, Any>)?["requestId"] as? String else {
            result(FlutterError.init(code: "-1", message: "missing requestId argument", details: call.arguments))
            return
        }
        let response = (call.arguments as? Dictionary<String, Any>)?["response"] as? String
        switch (call.method) {
            case "success" :
                if(requestId == "build"){
                    tikiSdk?.address = response!
                }
                print(response)
                tikiSdk!.completions[requestId]?(true, response)
            break
            case "error" :
                print(response)
                tikiSdk!.completions[requestId]?(false, response)
            break
            default : result(FlutterError(code: "-1", message: "Uninplemented", details: call.arguments))
        }
    }

    func setupChannel(apiKey: String, origin: String) {
        if (methodChannel == nil) {
            flutterEngine.run()
            GeneratedPluginRegistrant.register(with: self.flutterEngine);
            methodChannel = FlutterMethodChannel.init(name: channelId, binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
            methodChannel?.setMethodCallHandler(handle)
        }
        methodChannel!.invokeMethod(
            "build", arguments: [
                "apiKey" : apiKey,
                "origin" : origin,
                "requestId" : "build"
            ]
        )
    }
}
