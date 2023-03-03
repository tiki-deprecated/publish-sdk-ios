/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import FlutterPluginRegistrant
import SwiftUI

typealias OfferHandler = (Offer) -> Void

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
public class TikiSdk{
    
    public static var instance : TikiSdk = TikiSdk()
    public static var address : String{
        get throws{
            let addr = instance._address
            if(addr == nil){
                throw TikiSdkError(message: "Initialize TikiSdk calling TikiSdk.initTikiSdk()", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
            }
            return addr!
        }
    }
    
    var _address: String? = nil
    private var _onAccept: OfferHandler?
    private var _onDecline: OfferHandler?
    private var _onSettings: OfferHandler?
    private var _isAcceptEndingDisabled = false
    private var _isDeclineEndingDisabled = false
    private var _offers = [String: Offer]()
    private let _theme = Theme()
    private var _dark: Theme?
    private var tikiPlatformChannel: TikiPlatformChannel = TikiPlatformChannel()
    
    private init() {}
    
    public var theme: Theme {
        get{
            _theme
        }
    }
    
    public var dark: Theme {
        get{
            if(_dark == nil){
                _dark = Theme(dark: true)
            }
            return _dark!
        }
    }
    
    public var offer: Offer{
        get{
            Offer()
        }
    }
    
    func getActiveTheme(_ colorScheme: ColorScheme ) -> Theme {
        return colorScheme == .dark && _dark != nil ? _dark! : _theme
    }
    
    func license(offer: Offer, accepted: Bool) async throws{
        // TODO
    }
    
    func `guard`(ptr: String, uses: [String], onSuccess: @escaping () -> Void, onDenied: @escaping () -> Void) async throws -> Bool {
        return true
    }
    
    func present(in context: UIViewController) async throws {
       // TODO
    }

    /// Shows the pre built Settings UI
    static func settings(_ context: UIViewController) {
        // TODO
    }

    /// Starts the TikiSdk configuration.
    static func config() -> TikiSdk {
        return instance
    }

    /// Adds a new [Offer] for the user;
    func addOffer(_ offer: Offer) -> TikiSdk {
        _offers[offer.id] = offer
        return TikiSdk.instance
    }

    /// Disables the ending screen for accepted [Offer]
    func disableAcceptEnding(_ disable: Bool) -> TikiSdk {
        _isAcceptEndingDisabled = disable
        return self
    }

    /// Disables the ending screen for decline [Offer]
    func disableDeclineEnding(_ disable: Bool) -> TikiSdk {
        _isDeclineEndingDisabled = disable
        return self
    }

    /// Sets the callback function for an accepted offer.
    ///
    /// The onAccpet(...) event is triggered on the user's successful acceptance
    /// of the licensing offer. This happens after accepting the terms, not just
    /// on selecting "I'm In." The License Record is passed as a parameter to the
    /// callback function.
    func setOnAccept(_ onAccept: ((Offer) -> Void)?) -> TikiSdk {
        _onAccept = onAccept
        return self
    }

    /// Sets the callback function for a declined offer
    ///
    /// The onDecline() event is triggered when the user declines the licensing offer.
    /// This happens on dismissal of the flow or when "Back Off" is selected.
    func setOnDecline(_ onDecline: ((Offer) -> Void)?) -> TikiSdk {
        _onDecline = onDecline
        return self
    }

    /// Sets the callback function for user selecting the "settings" option in ending widget.
    ///
    /// The onSettings() event is triggered when the user selects "settings" in the
    /// ending screen. If a callback function is not registered, the SDK defaults to
    /// calling the TikiSdk.settings() method.
    func setOnSettings(_ onSettings: ((Offer) -> Void)?) -> TikiSdk {
        _onSettings = onSettings
        return self
    }
    
    /// Initializes the TIKI SDK.
    ///
    /// - Parameters:
    ///     - origin: The default *origin* for all transactions.
    ///     - publishingId: The *publishingId* for connecting to TIKI cloud.
    ///     - address: The *address* of the user node in TIKI blockchain. If nil a new address will be created.
    ///
    /// - Throws: *TikiSdkError*
    public func initTikiSdk(publishingId: String, address: String? = nil, origin: String? = nil) async throws{
        self.tikiPlatformChannel.channel = await withCheckedContinuation{(continuation: CheckedContinuation<FlutterMethodChannel, Never>) in
            DispatchQueue.main.async {
                let flutterEngine: FlutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
                flutterEngine.run()
                GeneratedPluginRegistrant.register(with: flutterEngine);
                let channel = FlutterMethodChannel.init(name: TikiPlatformChannel.channelId, binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
                channel.setMethodCallHandler(self.tikiPlatformChannel.handle)
                continuation.resume(returning: channel)
            }
        }
        let rspBuild: RspBuild = try await withCheckedThrowingContinuation{ continuation in
            let buildRequest = ReqBuild(publishingId: publishingId, origin: origin ?? Bundle.main.bundleIdentifier!, address: address)
            do{
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.BUILD,
                    request: buildRequest,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
            
        }
        self._address = rspBuild.address
    }

    /// Assign ownership to a given *source*.
    ///
    /// - Parameters:
    ///    - source: The identification of the data *source*.
    ///    - type: The *type* of data source (point, pool or stream) identified by *TikiSdkDataTypeEnum*.
    ///    - contains: The list of items the data *contains*.
    ///    - about: A description about the data.
    ///    - origin: Optional override for default origin.
    ///
    /// - Returns:A base64 url-safe no-padding representation of the ownership transaction id.
    /// - Throws: *TikiSdkError*
    public func assignOwnership(
        source: String,
        type: TikiSdkDataTypeEnum,
        contains: Array<String>,
        about: String? = nil,
        origin: String? = nil
    ) async throws -> String {
        let rspOwnership: RspOwnership = try await withCheckedThrowingContinuation{ continuation in
            do{
                let assignReq = ReqOwnershipAssign(
                    source: source, type: type, contains: contains, about: about, origin: origin)
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.ASSIGN_OWNERSHIP,
                    request: assignReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspOwnership.ownership!.transactionId
    }

    /// Gets the ownership for a *source*.
    ///
    /// - Parameters:
    ///    - source: The identification of the data *source*.
    ///    - origin: Optional override for default origin.
    /// - Returns: *TikiSdkOwnership*
    /// - Throws: *TikiSdkError*
    public func getOwnership(
        source : String,
        origin : String? = nil
    ) async throws -> TikiSdkOwnership? {
        let rspOwnership : RspOwnership = try await withCheckedThrowingContinuation{ continuation in
            do{
                let getReq = ReqOwnershipGet(
                    source: source, origin: origin)
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.GET_OWNERSHIP,
                    request: getReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspOwnership.ownership
    }

    /// Modify consent for an ownership identified by *ownershipId*.
    ///
    /// The Ownership must be granted before modifying consent. Consent is applied
    /// on an explicit only basis. Meaning all requests will be denied by default
    /// unless the destination is explicitly defined in *destination*.
    /// A blank list of *TikiSdkDestination.uses* or *TikiSdkDestination.paths*
    /// means revoked consent.
    ///
    /// - Parameters
    ///     - ownershipId: The transaction id of the ownership registry.
    ///     - destination: *TikiSdkDestination*.
    ///     - about: A description about the data.
    ///     - reward: An optional reward the user will receive for granting consent.
    ///     - expiry: The consent expiration date.
    ///
    /// - Returns: The created *TikiSdkConsent*.
    /// - Throws: *TikiSdkError*
    public func modifyConsent(
        ownershipId: String,
        destination: TikiSdkDestination,
        about: String? = nil,
        reward: String? = nil,
        expiry: Date? = nil
    ) async throws -> TikiSdkConsent {
        let rspConsent : RspConsentGet = try await withCheckedThrowingContinuation{ continuation in
            do{   let getReq = ReqConsentModify(ownershipId : ownershipId,
                                                destination : destination,
                                                about: about,
                                                reward: reward,
                                                expiry:  expiry)
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.MODIFY_CONSENT,
                    request: getReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspConsent.consent!
    }

    /// Gets latest consent given for a *source* and *origin*.
    ///
    /// It does not validate if the consent is expired or if it can be applied to
    /// a specific destination. For that, *applyConsent* should be used instead.
    /// If no *origin* is specified, it uses the default origin.
    ///
    /// - Parameters
    ///     - source: The identification of the data *source*.
    ///     - origin: Optional override for default origin.
    ///
    /// - Returns: Latest *TikiSdkConsent* for *source* and *origin*.
    /// - Throws: *TikiSdkError*
    public func getConsent(
        source: String,
        origin: String? = nil
    ) async throws -> TikiSdkConsent? {
        let rspConsent: RspConsentGet = try await withCheckedThrowingContinuation{ continuation in
            do{
                let getReq = ReqConsentGet(
                    source: source, origin: origin)
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.GET_CONSENT,
                    request: getReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspConsent.consent
    }

    /// Apply consent for a given *source* and *destination*.
    ///
    /// If consent exists for the destination and is not expired, *request* will be
    /// executed. Else *onBlocked* is called.
    ///
    /// - Parameters
    ///     - source: The identification of the data *source*.
    ///     - destination: *TikiSdkDestination*.
    ///     - request: The function to run if the consent is given.
    ///     - onBlocked: The function to run if the consent is not given.
    ///     - origin: Optional override for default origin.
    public func applyConsent(
        source: String,
        destination: TikiSdkDestination,
        request:  (() -> Void),
        onBlocked:  ((String) -> Void)? = nil,
        origin: String? = nil
    ) async throws -> Void {
        let rspConsentApply: RspConsentApply = try await withCheckedThrowingContinuation{ continuation in
            let getReq = ReqConsentApply(
                source: source, destination: destination, origin: origin)
            do{
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.APPLY_CONSENT,
                    request: getReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        if(rspConsentApply.success){
            request();
        }else{
            onBlocked?(rspConsentApply.reason ?? "no consent")
        }
    }
}
