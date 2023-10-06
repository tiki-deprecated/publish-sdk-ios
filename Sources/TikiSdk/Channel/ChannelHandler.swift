/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import Flutter

public class ChannelHandler{
    
    static let channelId = "com.mytiki.sdk"
    
    private var callbacks: Dictionary<String, ((_ rsp: [String: Any?], _ error: Error?) -> Void)>
    private var channel: FlutterMethodChannel
    
    init(_ channel: FlutterMethodChannel) {
        self.callbacks = [:]
        self.channel = channel
        self.channel.setMethodCallHandler(self.handle)
    }
    
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
        let response: [String: Any?] = call.arguments as! [String: Any?]
        switch (call.method) {
        case "success" :
            let callback = callbacks[requestId]!
            callback(response, nil)
            break
        case "error" :
            let rspError = RspError(from: response)
            callbacks[requestId]?([:], TikiSdkError(message: rspError.message, stackTrace: rspError.stackTrace))
            break
        default :
            result(FlutterError(code: "404", message: "Not Found", details: call.arguments))
            callbacks[requestId]?([:], TikiSdkError(message: "Unimplemented method", stackTrace: Thread.callStackSymbols.joined(separator: "\n")))
        }
        callbacks.remove(at: callbacks.index(forKey: requestId)!)
    }
    
    public func invokeMethod<T: Req>(
        method: ChannelMethod,
        request: T,
        continuation: CheckedContinuation<[String: Any?], Error>) {
        let reqDictionary = request.asDictionary()
        callbacks[request.requestId] = { rsp, err in
            if(err != nil){
                continuation.resume(throwing: err!)
            }else{
                continuation.resume(returning: rsp)
            }
        }
        DispatchQueue.main.async {
            self.channel.invokeMethod( method.value(), arguments: reqDictionary )
            print("invoke method")
        }
    }
}
