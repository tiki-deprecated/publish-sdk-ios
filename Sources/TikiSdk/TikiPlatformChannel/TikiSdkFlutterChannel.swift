import Flutter
import FlutterPluginRegistrant

/// The definition of Flutter Platform Channels for TIKI SDK
public class TikiSdkFlutterChannel {
    
    public var channel: FlutterMethodChannel? = nil
    
    static let channelId = "tiki_sdk_flutter"
    var callbacks: Dictionary<String, ((_ jsonString : String?, _ error : Error?) -> Void)> = [:]
   
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
        guard let requestId : String = (call.arguments as? Dictionary<String, Any>)?["requestId"] as? String else {
            result(FlutterError.init(code: "-1", message: "missing requestId argument", details: call.arguments))
            return
        }
        switch (call.method) {
            case "success" :
                let callback = callbacks[requestId]!
                callback(response, nil)
            break
            case "error" :
                do{
                    let rspError = try JSONDecoder().decode(RspError.self, from:  Data(response.utf8))
                    callbacks[requestId]?(nil, TikiSdkError(message: rspError.message, stackTrace: rspError.stackTrace))
                }catch{
                    callbacks[requestId]?(nil, TikiSdkError(message: error.localizedDescription, stackTrace: Thread.callStackSymbols.joined(separator: "\n")))
                }
            break
            default :
                result(FlutterError(code: "-1", message: "Uninplemented", details: call.arguments))
            callbacks[requestId]?(nil, TikiSdkError(message: "Unimplemented method", stackTrace: Thread.callStackSymbols.joined(separator: "\n")))
        }
        callbacks.remove(at: callbacks.index(forKey: requestId)!)
    }
    
    public func invokeMethod<T: Decodable>(
           method: MethodEnum,
           request: Req,
           continuation: CheckedContinuation<T, Error>
    ) -> Void {
           let requestId = UUID().uuidString
           let jsonRequest = String(data: request.toJSONData()!, encoding: String.Encoding.utf8)
           callbacks[requestId] = { jsonString, err in
               if(err != nil){
                   continuation.resume(throwing: err!)
               }
               do{
                   let rsp: T = try JSONDecoder().decode(T.self, from: Data(jsonString!.utf8))
                   continuation.resume(returning: rsp)
               }catch{
                   continuation.resume(throwing: error)
               }
           }
           channel!.invokeMethod(
            method.rawValue, arguments: [
                    "requestId" : requestId,
                    "request" : jsonRequest
                ]
           )
       }
}


