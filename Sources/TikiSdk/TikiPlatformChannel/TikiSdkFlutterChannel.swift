import Flutter
import FlutterPluginRegistrant

/// The definition of Flutter Platform Channels for TIKI SDK
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
        guard let response = (call.arguments as? Dictionary<String, Any>)?["response"] as? String else {
            result(FlutterError.init(code: "-1", message: "missing response argument", details: call.arguments))
            return
        }
        let jsonDictionary = (try? JSONSerialization.jsonObject(with: response.data(using: .utf8)!, options: []) as? [String: Any])
        guard let requestId : String = jsonDictionary!["requestId"] as? String else {
            result(FlutterError.init(code: "-1", message: "missing requestId in response", details: call.arguments))
            return
        }
        switch (call.method) {
            case "success" :
                if(requestId == "build"){
                    guard let address : String = jsonDictionary!["address"] as? String else {
                        result(FlutterError.init(code: "-1", message: "missing address in success response", details: call.arguments))
                        return
                    }
                    tikiSdk!.address = address
                }
                tikiSdk!.continuations[requestId]?.resume(returning: response)
            break
            case "error" :
                do{
                    let rspError = try JSONDecoder().decode(RspError.self, from:  Data(response.utf8))
                    tikiSdk!.continuations[requestId]?.resume(throwing: TikiSdkError(message: rspError.message, stackTrace: rspError.stackTrace))
                }catch{
                    tikiSdk!.continuations[requestId]?.resume(throwing: TikiSdkError(message: "Could not decode error message from Flutter: \(response)", stackTrace: Thread.callStackSymbols.joined(separator: "\n")))
                }
            break
            default :
                result(FlutterError(code: "-1", message: "Uninplemented", details: call.arguments))
                tikiSdk!.continuations[requestId]?.resume(throwing: TikiSdkError(message: "Uninplemented method", stackTrace: Thread.callStackSymbols.joined(separator: "\n")))
        }
    }

}
