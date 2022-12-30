/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import FlutterPluginRegistrant

/// The definition of Flutter Platform Channels for TIKI SDK
public class TikiPlatformChannel {
    
    public var channel: FlutterMethodChannel? = nil
    
    static let channelId = "tiki_sdk_flutter"
    var callbacks: Dictionary<String, ((_ jsonString : String?, _ error : Error?) -> Void)> = [:]
   
    /// Handles the method calls from Flutter.
    ///
    /// When calling TIKI SDK Flutter from native code, one should pass a requestId
    /// that will identify to which request the response belongs to.
    /// All the calls are asynchronous and should be treated like this.
    public func handle(call: FlutterMethodCall, result: @escaping FlutterResult){
        guard let requestId : String = (call.arguments as? Dictionary<String, Any>)?["requestId"] as? String else {
            result(FlutterError.init(code: "400", message: "Bad Request", details: ["arguments" : call.arguments, "description" : "Missing requestId"]))
            return
        }
        let response: String = (call.arguments as? Dictionary<String, Any>)?["response"] as? String ?? ""
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
                result(FlutterError(code: "404", message: "Not Found", details: call.arguments))
                callbacks[requestId]?(nil, TikiSdkError(message: "Unimplemented method", stackTrace: Thread.callStackSymbols.joined(separator: "\n")))
        }
        callbacks.remove(at: callbacks.index(forKey: requestId)!)
    }
    
    public func invokeMethod<T: Decodable, R: Encodable>(
           method: MethodEnum,
           request: R,
           continuation: CheckedContinuation<T, Error>
    ) throws -> Void {
           let requestId = UUID().uuidString
           let jsonData = try JSONEncoder().encode(request)
           let jsonRequest = String(data: jsonData, encoding: String.Encoding.utf8)
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


