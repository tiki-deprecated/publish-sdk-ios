/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import FlutterPluginRegistrant
import SwiftUI
import UIKit

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
public class TikiSdk{
    
    public var idp: Idp {
        get throws {
            if(_channel == nil) {
                throw(
                    TikiSdkError(
                        message: "SDK not initialized. Call .initialize(...)",
                        stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
                )
            }
            if( _idp == nil) {
                _idp = Idp(channel: _channel!)
            }
            return _idp!
        }
    }
    
    
    public var trail: Trail {
        get throws {
            if(_channel == nil) {
                throw(
                    TikiSdkError(
                        message: "SDK not initialized. Call .initialize(...)",
                        stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
                )
            }
            if( _trail == nil) {
                _trail = Trail(channel: _channel!)
            }
            return _trail!
        }
    }
    
    ///Initializes the TIKI SDK.
    ///
    ///Use this method to initialize the TIKI SDK with the specified *publishingId*, *id*, and *origin*.
    ///You can also provide an optional `onComplete` closure that will be executed once the initialization process is complete.
    /// - Parameters:
    ///   - publishingId: The *publishingId* for connecting to the TIKI cloud.
    ///   - id: The ID that uniquely identifies your user.
    ///   - onComplete: An optional closure to be executed once the initialization process is complete.
    ///   - origin: The default *origin* for all transactions. Defaults to `Bundle.main.bundleIdentifier` if *nil*.
    /// - Throws: `TikiSdkError` if the initialization process encounters an error.
    public func initialize( id: String, publishingId: String,  onComplete: (() -> Void)? = nil ) async throws {
        if( _channel == nil ){
            try await withCheckedThrowingContinuation{ initChannel in
                _channel = Channel{
                    initChannel.resume()
                }
            }
        }
        let dbDir = NSSearchPathForDirectoriesInDomains(
            FileManager.SearchPathDirectory.documentDirectory,
            FileManager.SearchPathDomainMask.userDomainMask,
            true)
        let reqInitialize = ReqInitialize(
            id: id,
            publishingId: publishingId,
            origin: Bundle.main.bundleIdentifier!,
            dir: dbDir.first! )
        let rspInitialize: RspInitialize = try await self._channel!.request( method: DefaultMethod.INITIALIZE,
            request: reqInitialize
        ){ rspDictionary in RspInitialize(from: rspDictionary) }
        self._address = rspInitialize.address

        DispatchQueue.main.sync {
            onComplete?()
        }
    }
    
    // MARK: Type properties
    
    /// The singleton instance of the TikiSdk.
    ///
    /// Accessing this property always returns the same instance of the `TikiSdk`.
    /// This property provides a global point of access to the TikiSdk instance, allowing it to be easily used throughout your app.
    public static var instance: TikiSdk = TikiSdk()
    
    /// Returns a Boolean value indicating whether the TikiSdk has been initialized.
    ///
    /// If `true`, it means that the TikiSdk has been successfully initialized.
    /// If `false`, it means that the TikiSdk has not yet been initialized or has failed to initialize.
    public static var isInitialized: Bool {
        return instance._address != nil
    }
    
    public static var address: String {
        get throws {
            try throwIfNotInitialized()
            return instance._address!
        }
    }
    
    public static var id: String {
        get throws {
            try throwIfNotInitialized()
            return instance._id!
        }
    }
    
    /// Starts the configuration process for the Tiki SDK instance.
    ///
    /// This method returns the shared instance of the Tiki SDK, which can be used to configure the SDK before initializing it.
    /// You can access instance variables such as `theme` or `offer`, and call methods such as `disableAcceptEnding(_:)`
    /// and `onAccept(_:)` on the returned instance to customize the SDK behavior to your needs.
    ///
    /// After the configuration is complete, you can initialize the SDK by calling `initialize(publishingId:id:onComplete:)`.
    /// Once the SDK is initialized, it is recommended to use the static methods instead of accessing the shared instance directly to
    /// avoid unnecessary dependency injection.
    ///
    /// To configure the Tiki SDK, you can use the builder pattern and chain the methods to customize the SDK behavior as needed.
    /// Here's an example:
    ///
    /// ```
    /// TikiSdk.config()
    ///    .theme
    ///        .primaryTextColor(.black)
    ///        .primaryBackgroundColor(.white)
    ///        .accentColor(.green)
    ///        .and()
    ///    .dark
    ///        .primaryTextColor(.white)
    ///        .primaryBackgroundColor(.black)
    ///        .accentColor(.green)
    ///        .and()
    ///    .offer
    ///        .bullet(text: "Use for ads", isUsed: true)
    ///        .bullet(text: "Share with 3rd party", isUsed: false)
    ///        .bullet(text: "Sell to other companies", isUsed: true)
    ///        .ptr("offer1")
    ///        .use(usecases: [Usecase(UsecaseCommon.support)])
    ///        .tag(Tag(TagCommon.advertisingData))
    ///        .duration(365 * 24 * 60 * 60)
    ///        .permission(Permission.camera)
    ///        .terms("terms.md")
    ///        .add()
    ///    .onAccept { offer, license in ... }
    ///    .onDecline { offer, license in ... }
    ///    .disableAcceptEnding(false)
    ///    .disableDeclineEnding(true)
    ///    .initialize(publishingId: publishingId, id:id, onComplete: {...})
    /// ```
    ///
    /// - Returns: The shared instance of the Tiki SDK.
    
    public static func config() -> TikiSdk {
        return instance
    }
    
    // MARK: Private properties
    
    private var _address: String?
    private var _id: String?
    
    private var _idp: Idp?
    private var _trail: Trail?
    private var _channel: Channel?
    
    // MARK: Private methods
    
    private init() {}
    
    private static func throwIfNotInitialized() throws{
        if(!TikiSdk.isInitialized){
            throw TikiSdkError(message: "Please ensure that the TIKI SDK is properly initialized by calling initialize().", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
    }

}
