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
    
    public static var instance : TikiSdk = TikiSdk()
    public static var address : String?{
        get {
            return instance._address
        }
    }
    
    private var _address: String? = nil
    private var _onAccept: ((Offer, LicenseRecord) -> Void)?
    private var _onDecline: ((Offer, LicenseRecord?)  -> Void)?
    private var _onSettings: (() -> Void) = {
        try? TikiSdk.settings()
    }
    private var _isAcceptEndingDisabled = false
    private var _isDeclineEndingDisabled = false
    private var _offers = [String: Offer]()
    private let _theme = Theme()
    private var _dark: Theme?
    private var _defaultTerms: String = "default terms"
    private var coreChannel: CoreChannel = CoreChannel()
    
    private init() {}
    
    public var theme: Theme {
        get{
            _theme
        }
    }
    
    public var dark: Theme {
        get{
            if(_dark == nil){
                _dark = Theme()
            }
            return _dark!
        }
    }
    
    public var offer: Offer{
        get{
            Offer()
        }
    }
    
    public var offers: [String:Offer]{
        get{
            _offers
        }
    }

    public var isDeclineEndingDisabled: Bool{
        get{
            _isDeclineEndingDisabled
        }
    }
    
    public var isAcceptEndingDisabled: Bool{
        get{
            _isAcceptEndingDisabled
        }
    }
    
    static func theme(_ colorScheme: ColorScheme? = nil) -> Theme {
        return colorScheme != nil && colorScheme == .dark && instance._dark != nil ? instance._dark! : instance._theme
    }
    
    public static func present() throws {
        if(!isInitialized()){
            throw TikiSdkError(message: "Please ensure that the TIKI SDK is properly initialized by calling initialize().", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        if(instance.offers.isEmpty){
            throw TikiSdkError(message: "To proceed, kindly utilize the TikiSdk.offer() method to include at least one offer.", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        let viewController = UIApplication.shared.windows.first?.rootViewController
        let vc = UIHostingController(
            rootView:OfferFlow(
                activeOffer: TikiSdk.instance.offers.values.first!,
                offers: TikiSdk.instance.offers,
                onSettings: instance._onSettings,
                onDismiss: {viewController!.dismiss( animated: true, completion: nil )},
                onAccept: instance._onAccept,
                onDecline: instance._onDecline
                )
            )
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
        viewController!.present(vc, animated: true, completion: nil)
    }

    /// Shows the pre built Settings UI
    public static func settings() throws {
        if(!isInitialized()){
            throw TikiSdkError(message: "Please ensure that the TIKI SDK is properly initialized by calling initialize().", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        if(instance.offers.isEmpty){
            throw TikiSdkError(message: "To proceed, kindly utilize the TikiSdk.offer() method to include at least one offer.", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        let viewController = UIApplication.shared.windows.first?.rootViewController
        let vc = UIHostingController(rootView: Settings(
            offers: TikiSdk.instance.offers,
            onDismiss: {
            viewController!.dismiss( animated: true, completion: nil )
            
        }))
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        viewController!.present(vc, animated: true, completion: nil)
    }

    /// Starts the TikiSdk configuration.
    public static func config() -> TikiSdk {
        return instance
    }
    
    /// Adds a new [Offer] for the user;
    public func addOffer(_ offer: Offer) -> TikiSdk {
        _offers[offer.id] = offer
        return TikiSdk.instance
    }
    
    /// Remove offer
    public func removeOffer(_ offerId: String) -> TikiSdk {
        _offers.removeValue(forKey: offerId)
        return TikiSdk.instance
    }

    /// Disables the ending screen for accepted [Offer]
    public func disableAcceptEnding(_ disable: Bool) -> TikiSdk {
        _isAcceptEndingDisabled = disable
        return self
    }

    /// Disables the ending screen for decline [Offer]
    public func disableDeclineEnding(_ disable: Bool) -> TikiSdk {
        _isDeclineEndingDisabled = disable
        return self
    }

    /// Sets the callback function for an accepted offer.
    ///
    /// The onAccpet(...) event is triggered on the user's successful acceptance
    /// of the licensing offer. This happens after accepting the terms, not just
    /// on selecting "I'm In." The License Record is passed as a parameter to the
    /// callback function.
    public func onAccept(_ onAccept: ((Offer, LicenseRecord) -> Void)?) -> TikiSdk {
        _onAccept = onAccept
        return self
    }

    /// Sets the callback function for a declined offer
    ///
    /// The onDecline() event is triggered when the user declines the licensing offer.
    /// This happens on dismissal of the flow or when "Back Off" is selected.
    public func onDecline(_ onDecline: ((Offer, LicenseRecord?) -> Void)?) -> TikiSdk {
        _onDecline = onDecline
        return self
    }

    /// Sets the callback function for user selecting the "settings" option in ending widget.
    ///
    /// The onSettings() event is triggered when the user selects "settings" in the
    /// ending screen. If a callback function is not registered, the SDK defaults to
    /// calling the TikiSdk.settings() method.
    public func onSettings(_ onSettings: @escaping () -> Void) -> TikiSdk {
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
    public func initialize(publishingId: String, id: String, onComplete: (() -> Void)? = nil, origin: String? = nil) throws{
        Task{
            let rspBuild: RspInit = try await withCheckedThrowingContinuation{ continuation in
                let buildRequest = ReqInit(publishingId: publishingId, id: id, origin: origin ?? Bundle.main.bundleIdentifier!)
                do{
                    try self.coreChannel.invokeMethod(
                        method: CoreMethod.build,
                        request: buildRequest,
                        continuation: continuation
                    )
                }catch{
                    continuation.resume(throwing: error)
                }
                
            }
            self._address = rspBuild.address
            DispatchQueue.main.async {
                onComplete?()
            }
        }
    }

    
    /**
     * Create a new LicenseRecord.
     *
     * If a TitleRecord for the Offer.ptr is not found, a new TitleRecord is created.
     * If a TitleRecord is found, Offer.tags and Offer.description parameters are ignored.
     *
     * - Parameters:
     *   - offer: The Offer object containing details of the offer.
     *   - accepted: The date when the license was accepted.
     * - Returns: The newly created LicenseRecord object.
     */
    public static func license(offer: Offer) async throws -> LicenseRecord {
        
        let rspLicense: RspLicense = try await withCheckedThrowingContinuation{ continuation in
            do{
                let licenseReq = ReqLicense(
                    ptr: offer.ptr,
                    terms: offer.terms,
                    licenseDescription: offer.description,
                    uses: offer.uses,
                    tags: offer.tags,
                    expiry: offer.expiry
                )
                try instance.coreChannel.invokeMethod(
                    method: CoreMethod.license,
                    request: licenseReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspLicense.license!
    }
    
    /**
     * Guard against an invalid LicenseRecord for a List of usecases an destinations.
     *
     * Use this method to verify a non-expired, LicenseRecord for the ptr exists,
     * and permits the listed usecases and destinations.
     *
     * This method can be used in two forms,
     * 1) async as a traditional guard, returning a pass/fail boolean. Or
     * 2) as a wrapper around function.
     *
     * For example: An http that you want to run IF permitted by a LicenseRecord.
     *
     * Option 1:
     * ```
     * let pass = await guard("ptr", [LicenseUsecase.attribution()]);
     * if(pass) {
     *     http.post(...);
     * }
     * ```
     *
     * Option 2:
     * ```
     * guard('ptr', [LicenseUsecase.attribution()], onPass: () => http.post(...));
     * ```
     *
     * - Parameters:
     *   - ptr: The Pointer Record for the asset. Used to located the latest relevant LicenseRecord.
     *   - usecases: A List of usecases defining how the asset will be used.
     *   - destinations: A List of destinations defining where the asset will be used. Often URLs.
     *   - onPass: A Function to execute automatically upon successfully resolving the LicenseRecord
     *     against the usecases and destinations.
     *   - onFail: A Function to execute automatically upon failure to resolve the LicenseRecord.
     *     Accepts a String parameter, holding an error message describing the reason for failure.
     *   - origin: An optional override of the default origin specified in.
     * - Returns: True if the user has access, false otherwise.
     */
    public static func `guard`(ptr: String, usecases: [LicenseUsecase], destinations: [String],
               onPass: (() -> Void)? = nil, onFail: ((String?) -> Void)? = nil, origin: String? = nil) async throws -> Bool {
        let rspGuard: RspGuard = try await withCheckedThrowingContinuation{ continuation in
            let guardReq = ReqGuard(ptr: ptr, usecases: usecases, destinations: destinations, origin: origin)
            do{
                try instance.coreChannel.invokeMethod(
                    method: CoreMethod.guard,
                    request: guardReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        if(rspGuard.success){
            onPass?();
        }else{
            onFail?(rspGuard.reason)
        }
        return rspGuard.success
    }
    
    /**
     Creates a new TitleRecord.
     - Parameters:
        - ptr: The Pointer Records identifies data stored in your system, similar to a foreign key. Learn more about selecting good pointer records at https://docs.mytiki.com/docs/selecting-a-pointer-record.
        - origin: An optional override of the default origin specified in initTikiSdkAsync. Follow a reverse-DNS syntax, i.e. com.myco.myapp.
        - tags: A list of metadata tags included in the TitleRecord describing the asset, for your use in record search and filtering. Learn more about adding tags at https://docs.mytiki.com/docs/adding-tags.
        - description: A short, human-readable, description of the TitleRecord as a future reminder.
     - Returns: The created TitleRecord.
     */
    public static func title(ptr: String, origin: String? = nil, tags: [TitleTag]? = [], description: String? = nil) async throws -> TitleRecord{
        let rspTitle: RspTitle = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqTitle = ReqTitle(
                    ptr: ptr,
                    tags: tags ?? [],
                    origin: origin
                )
                try instance.coreChannel.invokeMethod(
                    method: CoreMethod.title,
                    request: reqTitle,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspTitle.title!
    }

    /**
     Returns the TitleRecord for an id or nil if the record is not found.
     - Parameter id: The id of the TitleRecord to retrieve.
     - Returns: The TitleRecord or nil if the record is not found.
     */
    public static func getTitle(id: String, origin: String? = nil) async throws -> TitleRecord?{
        let rspTitle: RspTitle = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqTitle = ReqTitleGet(
                    id: id,
                    origin: origin
                )
                try instance.coreChannel.invokeMethod(
                    method: CoreMethod.getTitle,
                    request: reqTitle,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspTitle.title
    }

    /**
     Returns the LicenseRecord for an id or nil if the license or corresponding title record is not found.
     - Parameter id: The id of the LicenseRecord to retrieve.
     - Returns: The LicenseRecord or nil if the license or corresponding title record is not found.
     */
    public static func getLicense(id: String, origin: String? = nil) async throws -> LicenseRecord? {
        let rspLicense: RspLicense = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqLicense = ReqTitleGet(
                    id: id,
                    origin: origin
                )
                try instance.coreChannel.invokeMethod(
                    method: CoreMethod.getLicense,
                    request: reqLicense,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspLicense.license
    }

    /**
     Returns all LicenseRecords for a ptr.
     - Parameters:
        - ptr: The Pointer Records identifies data stored in your system, similar to a foreign key.
        - origin: An optional origin. If nil, origin defaults to the package name.
     - Returns: An array of all LicenseRecords for the given ptr.
     */
    public static func all(ptr: String, origin: String? = nil) async throws -> [LicenseRecord] {
        let rspAll: RspLicenseList = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqAll = ReqLicenseAll(
                    ptr: ptr,
                    origin: origin
                )
                try instance.coreChannel.invokeMethod(
                    method: CoreMethod.all,
                    request: reqAll,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspAll.licenseList
    }

    /**
     Returns the latest LicenseRecord for a ptr or nil if the title or license records are not found.
     - Parameters:
        - ptr: The Pointer Records identifies data stored in your system, similar to a foreign key.
        - origin: An optional origin. If nil, origin defaults to the package name.
     - Returns: The latest LicenseRecord or nil if the title or license records are not found.
     */
    public static func latest(ptr: String, origin: String? = nil) async throws -> LicenseRecord?{
        let rspLicense: RspLicense = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqLicense = ReqLicenseLatest(
                    ptr: ptr,
                    origin: origin
                )
                try instance.coreChannel.invokeMethod(
                    method: CoreMethod.latest,
                    request: reqLicense,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspLicense.license
    }
    
    public static func isInitialized() -> Bool{
        return address != nil
    }
}

