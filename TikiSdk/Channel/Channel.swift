/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import FlutterPluginRegistrant

/// The definition of Flutter Platform Channels for TIKI SDK
public class Channel {
    
    private var handler: ChannelHandler?
    
    private init(handler: ChannelHandler) {
        self.handler = handler
    }
    
    static public func initialize(onCompletion: @escaping ((Channel) -> Void)){
        let flutterEngine: FlutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
        
        DispatchQueue.main.async {
            
            flutterEngine.run()
            Task{
                GeneratedPluginRegistrant.register(with: flutterEngine);
                let channel = Channel(handler: ChannelHandler(FlutterMethodChannel.init(
                    name: ChannelHandler.channelId,
                    binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
                ))
                onCompletion(channel)
            }}
    }
    
    func request<T: Req, R: Rsp>(
        method: ChannelMethod,
        request: T,
        toResponse: @escaping ( [String: Any?] ) -> R
    ) async throws -> R {
        guard let handler = handler else {
            fatalError("Channel not initialized yet. Use Channel.initialize(onCompletion: ...).")
        }
        let rsp: [String: Any?] = try await withCheckedThrowingContinuation{ continuation in
            handler.invokeMethod(
                method: method,
                request: request,
                continuation: continuation
            )
        }
        return toResponse(rsp)
    }
    
}

