import Flutter

public class TikiSdkFlutterChannel: FlutterMethodChannel {

    let channelId = "tiki_sdk_flutter"
    var flutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
    public var tikiSdk: TikiSdk?
    
    public var methodChannel: FlutterMethodChannel? = nil

    public init(apiKey: String? =  nil, origin: String? = nil) {
        super.init()
        if(methodChannel == nil){
            setupChannel(apiKey: apiKey ?? "", origin: origin ?? "")
        }
    }
    
    @objc(handleMethodCall:result:) public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let requestId = (call.arguments as! Dictionary<String, String>)["requestId"] else {
            result(FlutterError.init(code: "-1", message: "missing requestId argument", details: call.arguments))
            return
        }
        let response = (call.arguments as? Dictionary<String, String>)?["response"]
        switch (call.method) {
            case "success" :
                tikiSdk!.completions[requestId]!(true, response)
            break
            case "error" :
                tikiSdk!.completions[requestId]!(false, response)
            break
            default : result(FlutterError(code: "-1", message: "Uninplemented", details: call.arguments))
        }
    }

    func setupChannel(apiKey: String, origin: String) {
        if (methodChannel == nil) {
            flutterEngine.run()
            methodChannel = FlutterMethodChannel.init(name: channelId, binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
        }
        methodChannel!.invokeMethod(
            "build", arguments: [
                "apiKey" : apiKey,
                "origin" : origin
            ]
        )
    }
}
