import Flutter
import FlutterPluginRegistrant

public class TikiSdkFlutterChannel {

    static let channelId = "tiki_sdk_flutter"
    
    public var tikiSdk: TikiSdk?
    public var methodChannel: FlutterMethodChannel? = nil
    
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
                tikiSdk!.continuations[requestId]?.resume(returning: response ?? "")
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
