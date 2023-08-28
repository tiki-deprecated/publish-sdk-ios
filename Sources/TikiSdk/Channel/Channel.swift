/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import FlutterPluginRegistrant

/// The definition of Flutter Platform Channels for TIKI SDK
public class Channel {
    
    private var handler: ChannelHandler?
    
    public init(onCompletion: @escaping (() -> Void)) {
        let flutterEngine: FlutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
        DispatchQueue.main.async {
            flutterEngine.run()
            GeneratedPluginRegistrant.register(with: flutterEngine);
            self.handler = ChannelHandler(FlutterMethodChannel.init(
                name: ChannelHandler.channelId,
                binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
            )
            onCompletion()
        }
    }
    
    public func request<T: Req, R: Rsp>(
        method: ChannelMethod,
        request: T,
        toResponse: @escaping ( [String: Any?] ) -> R
    ) async throws -> R {
        guard let handler = handler else {
            fatalError("Channel not initialized. Call .initialize(...).")
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
    
