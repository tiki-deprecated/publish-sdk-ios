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
    
    // MARK: Instance properties
    
    /// A `Theme` object for pre-built UIs.
    ///
    /// - Returns: A `Theme` object with a dark mode appearance.
    public var theme: Theme {
        get{
            _theme
        }
    }
    
    /// A `Theme` object for pre-built UIs with a dark mode appearance.
    ///
    /// The dark mode theme is applied to the UI elements only when explicitly called. By default, the dark mode theme is identical to the
    /// default (light) theme. Each individual property of the dark mode theme can be customized during configuration.
    ///
    /// - Returns: A `Theme` object with a dark mode appearance.
    public var dark: Theme {
        get{
            if(_dark == nil){
                _dark = Theme()
            }
            return _dark!
        }
    }
    
    /// Creates a new, empty `Offer` object.
    ///
    /// This `Offer` object can be used to define a new offer before adding it to the TIKI SDK. To add the offer, call the `add(_:)` method
    /// on the `Offer` object.
    ///
    /// - Returns: A new, empty `Offer` object.
    public var offer: Offer {
        get{
            Offer()
        }
    }
    
    /// A dictionary containing all the offers that have been added to the TIKI SDK.
    ///
    /// The offers are stored in the dictionary using their ID as the key. To retrieve an offer, use its ID as the key to look up its
    /// corresponding `Offer` object in the dictionary.
    ///
    /// - Returns: A dictionary containing all the offers that have been added to the TIKI SDK.
    public var offers: [String:Offer]{
        get{
            _offers
        }
    }
    
    /// A Boolean value that determines whether the ending UI is disabled for declined offers in the pre-built UI.
    ///
    /// If this property is set to `true`, the ending UI will not be shown when an offer is declined.
    /// Otherwise, the ending UI will be shown as usual.
    ///
    /// - Returns: `true` if the ending UI is disabled for declined offers; otherwise, `false`.
    public var isDeclineEndingDisabled: Bool{
        get{
            _isDeclineEndingDisabled
        }
    }
    
    /// A Boolean value that determines whether the ending UI is disabled for accepted offers in the pre-built UI.
    ///
    /// If this property is set to `true`, the ending UI will not be shown when an offer is accepted.
    /// Otherwise, the ending UI will be shown as usual.
    ///
    /// - Returns: `true` if the ending UI is disabled for accepted offers; otherwise, `false`.
    public var isAcceptEndingDisabled: Bool{
        get{
            _isAcceptEndingDisabled
        }
    }
    
    // MARK: Instance methods
    
    /// Adds an `Offer` object to the `offers` dictionary, using its ID as the key.
    ///
    /// The `Offer` object is added to the `offers` dictionary with its ID as the key. If an offer with the same ID already exists in
    /// the dictionary, it will be overwritten by the new offer.
    ///
    /// - Parameter offer: The `Offer` object to add to the `offers` dictionary.
    /// - Returns: The `TikiSdk` instance.
    public func addOffer(_ offer: Offer) -> TikiSdk {
        _offers[offer.id] = offer
        return TikiSdk.instance
    }
    
    /// Removes an `Offer` object from the `offers` dictionary, using its ID as the key.
    ///
    /// The `Offer` object with the specified ID is removed from the `offers` dictionary. If no offer with the specified ID is found
    /// in the dictionary, this method has no effect.
    ///
    /// - Parameter offerId: The ID of the `Offer` object to remove from the `offers` dictionary.
    /// - Returns: The `TikiSdk` instance.
    public func removeOffer(_ offerId: String) -> TikiSdk {
        _offers.removeValue(forKey: offerId)
        return TikiSdk.instance
    }
    
    /// Disables or enables the ending UI for accepted offers.
    ///
    ///If this method is called with a parameter value of `true`, the ending UI will not be shown when an offer is accepted.
    ///If the parameter value is `false`, the ending UI will be shown as usual.
    ///
    ///- Parameter disable: A Boolean value indicating whether the ending UI for accepted offers should be disabled (`true`)
    /// or enabled (`false`).
    ///- Returns: The `TikiSdk` instance.
    public func disableAcceptEnding(_ disable: Bool) -> TikiSdk {
        _isAcceptEndingDisabled = disable
        return self
    }
    
    /// Disables or enables the ending UI for declined offers.
    ///
    /// f this method is called with a parameter value of `true`, the ending UI will not be shown when an offer is declined.
    /// If the parameter value is `false`, the ending UI will be shown as usual.
    ///
    /// - Parameter disable: A Boolean value indicating whether the ending UI for declined offers should be disabled (`true`)
    /// or enabled (`false`).
    /// - Returns: The `TikiSdk` instance.
    public func disableDeclineEnding(_ disable: Bool) -> TikiSdk {
        _isDeclineEndingDisabled = disable
        return self
    }
    
    /// Sets the callback function for when an offer is accepted.
    ///
    /// This method sets the `onAccept` event handler, which is triggered when the user accepts a licensing offer.
    ///
    /// - Parameter onAccept: The closure to be executed when an offer is declined. The closure takes two arguments: the
    /// `Offer` that was accepted, and the `LicenseRecord` object containing the license information for the accepted offer.
    /// - Returns: The `TikiSdk` instance.
    public func onAccept(_ onAccept: ((Offer, LicenseRecord) -> Void)?) -> TikiSdk {
        _onAccept = onAccept
        return self
    }
    
    /// Sets the callback function for when an offer is declined.
    ///
    /// This method sets the `onDecline` event handler, which is triggered when the user declines a licensing offer.
    /// The event is triggered either when the offer flow is dismissed or when the user selects "Back Off".
    ///
    /// - Parameter onDecline: The closure to be executed when an offer is declined. The closure takes two arguments: the
    /// `Offer` that was declined, and an optional `LicenseRecord` object containing the license information for the declined offer,
    /// if it was accepted before.
    /// - Returns: The `TikiSdk` instance.
    public func onDecline(_ onDecline: ((Offer, LicenseRecord?) -> Void)?) -> TikiSdk {
        _onDecline = onDecline
        return self
    }
    
    /// Sets the callback function for when the user selects "Settings" in the ending widget.
    ///
    /// This method sets the `onSettings()` event handler, which is triggered when the user selects "Settings" in the ending screen.
    /// If a callback function is not registered, the SDK will default to calling the `TikiSdk.settings()` method.
    ///
    /// - Parameter onSettings: The closure to be executed when the "Settings" option is selected. The closure takes no arguments and returns no value.
    /// - Returns: The `TikiSdk` instance.
    public func onSettings(_ onSettings: @escaping () -> Void) -> TikiSdk {
        _onSettings = onSettings
        return self
    }
    
    ///Initializes the TIKI SDK.
    ///
    ///Use this method to initialize the TIKI SDK with the specified *publishingId*, *id*, and *origin*.
    ///You can also provide an optional `onComplete` closure that will be executed once the initialization process is complete.
    /// - Parameters:
    ///    - publishingId: The *publishingId* for connecting to the TIKI cloud.
    ///   - id: The ID that uniquely identifies your user.
    ///   - onComplete: An optional closure to be executed once the initialization process is complete.
    ///   - origin: The default *origin* for all transactions. Defaults to `Bundle.main.bundleIdentifier` if *nil*.
    /// - Throws: `TikiSdkError` if the initialization process encounters an error.
    public func initialize(publishingId: String, id: String, onComplete: (() -> Void)? = nil, origin: String? = nil) throws {
        Task{
            let rspBuild: RspInit = try await withCheckedThrowingContinuation{ continuation in
                let dbDir = NSSearchPathForDirectoriesInDomains(
                    FileManager.SearchPathDirectory.documentDirectory,
                    FileManager.SearchPathDomainMask.userDomainMask,
                    true)
                let buildRequest = ReqInit(publishingId: publishingId, id: id, origin: origin ?? Bundle.main.bundleIdentifier!, dbDir: dbDir.first! )
                do{
                    try self._coreChannel.invokeMethod(
                        method: CoreMethod.build,
                        request: buildRequest,
                        continuation: continuation
                    )
                }catch{
                    continuation.resume(throwing: error)
                }
                
            }
            self._address = rspBuild.address
            DispatchQueue.main.sync {
                onComplete?()
            }
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
    
    
    // MARK: Type Methods
    
    /// Presents an `Offer` to the user and allows them to accept or decline it, which can result in a new `LicenseRecord`
    /// being created based on the presented `Offer`.
    ///
    /// If the `Offer` has already been accepted by the user, this method does nothing.
    ///
    /// This method creates a new `UIHostingController` that holds the Tiki SDK's pre-built user interface for the Offer
    /// prompt and presents it with the current root view controller. When the user finishes the `Offer` flow by dismissing it or
    /// accepting/declining the `Offer`, the root view controller is called again to dismiss the created hosting controller.
    ///
    /// - Throws: `TikiSdkError` if the SDK is not initialized or if no `Offer` was created.
    public static func present() throws {
        try throwIfNotInitialized()
        try throwIfNoOffers()
        
        let presentOffer = {
            DispatchQueue.main.async {
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
        }
        Task{
            let ptr : String = TikiSdk.instance.offers.values.first!.ptr!
            var usecases: [LicenseUsecase] = []
            var destinations: [String] = []
            TikiSdk.instance.offers.values.first!.uses.forEach{ licenseUse in
                if(licenseUse.destinations != nil){
                    destinations.append(contentsOf: licenseUse.destinations!)
                }
                usecases.append(contentsOf: licenseUse.usecases)
            }
            let _ = try await self.guard(ptr: ptr, usecases: usecases, destinations: destinations, onFail: {_ in presentOffer()})
        }
    }
    
    /// Presents the Tiki SDK's pre-built user interface for the settings screen, which allows the user to accept or decline the current offer.
    ///
    /// This method creates a new `UIHostingController` that holds the Tiki SDK's pre-built user interface for the settings screen
    /// and presents it with the current root view controller. When the user dismisses the screen, the root view controller is called again
    /// to dismiss the created hosting controller.
    ///
    /// - Throws: `TikiSdkError` if the SDK is not initialized or if no `Offer` was created.
    public static func settings() throws {
        try throwIfNotInitialized()
        try throwIfNoOffers()
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
    ///        .use(usecases: [LicenseUsecase(LicenseUsecaseEnum.support)])
    ///        .tag(TitleTag(TitleTagEnum.advertisingData))
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
    
    /// Returns the `Theme` configured for the specified *colorScheme*, or the default theme if none is specified or the specified
    /// color scheme does not exist.
    ///
    /// If a dark theme has been defined and a color scheme of `.dark` is requested, the dark theme will be returned instead of the
    /// default theme.
    ///
    /// - Parameter colorScheme: The color scheme for which to retrieve the theme. If nil, the default theme is returned.
    /// - Returns: The `Theme` configured for the specified color scheme, or the default theme if none is specified or the specified
    ///            color scheme does not exist.
    public static func theme(_ colorScheme: ColorScheme? = nil) -> Theme {
        return colorScheme != nil && colorScheme == .dark && instance._dark != nil ? instance._dark! : instance._theme
    }
    
    /// Creates a new `LicenseRecord` object.
    ///
    /// The method searches for a `TitleRecord` object that matches the provided `ptr` parameter. If such a record exists, the
    /// `tags` and `titleDescription` parameters are ignored. Otherwise, a new `TitleRecord` is created using the provided
    /// `tags` and `titleDescription` parameters.
    ///
    /// If the `origin` parameter is not provided, the default origin specified in initialization is used.
    /// The `expiry` parameter sets the expiration date of the `LicenseRecord`. If the license never expires, leave this parameter
    /// as `nil`.
    ///
    /// - Parameters:
    ///   - ptr: The pointer record identifies data stored in your system, similar to a foreign key. Learn more about selecting good pointer
    ///   records at https://docs.mytiki.com/docs/selecting-a-pointer-record.
    ///   - uses: A list defining how and where an asset may be used, in the format of `LicenseUse` objects. Learn more about specifying
    ///   uses at https://docs.mytiki.com/docs/specifying-terms-and-usage.
    ///   - terms: The legal terms of the contract. This is a long text document that explains the terms of the license.
    ///   - tags: A list of metadata tags included in the `TitleRecord` describing the asset, for your use in record search and filtering.
    ///   This parameter is used only if a `TitleRecord` does not already exist for the provided `ptr`.
    ///   - titleDescription: A short, human-readable description of the `TitleRecord` as a future reminder. This parameter is used
    ///   only if a `TitleRecord` does not already exist for the provided `ptr`.
    ///   - licenseDescription: A short, human-readable description of the `LicenseRecord` as a future reminder.
    ///   - expiry: The expiration date of the `LicenseRecord`. If the license never expires, leave this parameter as `nil`.
    ///   - origin: An optional override of the default origin specified in `init()`. Use a reverse-DNS syntax, e.g. `com.myco.myapp`.
    ///
    /// - Returns: The created `LicenseRecord` object.
    ///
    /// - Throws: `TikiSdkError` if the SDK is not initialized or if there is an error creating or saving the record.
    public static func license(_ ptr: String,
                               _ uses: [LicenseUse],
                               _ terms: String,
                               tags: [TitleTag] = [],
                               titleDescription: String? = nil,
                               licenseDescription: String? = nil,
                               expiry: Date? = nil,
                               origin: String? = nil) async throws -> LicenseRecord {
        let rspLicense: RspLicense = try await withCheckedThrowingContinuation{ continuation in
            do{
                let licenseReq = ReqLicense(
                    ptr: ptr,
                    terms: terms,
                    titleDescription: titleDescription,
                    licenseDescription: licenseDescription,
                    uses: uses,
                    tags: tags,
                    expiry: expiry
                )
                try instance._coreChannel.invokeMethod(
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
    
    /// Guard against an invalid LicenseRecord for a list of usecases and destinations.
    ///
    /// Use this method to verify that a non-expired LicenseRecord for the specified pointer record exists and permits the listed usecases and destinations.
    ///
    /// This method can be used in two ways:
    /// 1. As an async traditional guard, returning a pass/fail boolean:
    /// ```
    /// let pass = await `guard`(ptr: "example-ptr", usecases: [.attribution], destinations: ["https://example.com"])
    /// if pass {
    ///     // Perform the action allowed by the LicenseRecord.
    /// }
    /// ```
    /// 2. As a wrapper around a function:
    /// ```
    /// `guard`(ptr: "example-ptr", usecases: [.attribution], destinations: ["https://example.com"], onPass: {
    ///     // Perform the action allowed by the LicenseRecord.
    /// }, onFail: { error in
    ///     // Handle the error.
    /// })
    /// ```
    ///
    /// - Parameters:
    ///   - ptr: The pointer record for the asset. Used to locate the latest relevant LicenseRecord.
    ///   - usecases: A list of usecases defining how the asset will be used.
    ///   - destinations: A list of destinations defining where the asset will be used, often URLs.
    ///   - onPass: A closure to execute automatically upon successfully resolving the LicenseRecord against the usecases and destinations.
    ///   - onFail: A closure to execute automatically upon failure to resolve the LicenseRecord. Accepts an optional error message describing the reason for failure.
    ///   - origin: An optional override of the default origin specified in the initializer.
    ///
    /// - Returns: `true` if the user has access, `false` otherwise.
    public static func `guard`(ptr: String, usecases: [LicenseUsecase], destinations: [String],
                               onPass: (() -> Void)? = nil, onFail: ((String?) -> Void)? = nil, origin: String? = nil) async throws -> Bool {
        let rspGuard: RspGuard = try await withCheckedThrowingContinuation{ continuation in
            let guardReq = ReqGuard(ptr: ptr, usecases: usecases, destinations: destinations, origin: origin)
            do{
                try instance._coreChannel.invokeMethod(
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
    
    /// Creates a new TitleRecord, or retrieves an existing one.
    ///
    /// Use this function to create a new TitleRecord for a given Pointer Record (ptr), or retrieve an existing one if it already exists.
    /// - Parameters:
    ///     - ptr: The Pointer Record that identifies the data stored in your system, similar to a foreign key. Learn more about selecting good pointer records at https://docs.mytiki.com/docs/selecting-a-pointer-record.
    ///     - origin: An optional override of the default origin specified in `initTikiSdkAsync`. Follow a reverse-DNS syntax,
    ///     i.e. com.myco.myapp.
    ///     - tags: A list of metadata tags included in the TitleRecord describing the asset, for your use in record search and filtering. Learn
    ///     more about adding tags at https://docs.mytiki.com/docs/adding-tags.
    ///     - description: A short, human-readable, description of the TitleRecord as a future reminder.
    /// - Returns: The created or retrieved TitleRecord.
    public static func title(ptr: String, origin: String? = nil, tags: [TitleTag]? = [], description: String? = nil) async throws -> TitleRecord {
        
        let rspTitle: RspTitle = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqTitle = ReqTitle(
                    ptr: ptr,
                    tags: tags ?? [],
                    origin: origin
                )
                try instance._coreChannel.invokeMethod(
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
    
    /// Retrieves the TitleRecord with the specified ID, or `nil` if the record is not found.
    ///
    /// Use this method to retrieve the metadata associated with an asset identified by its TitleRecord ID.
    /// - Parameters
    ///  - id: The ID of the TitleRecord to retrieve.
    ///  - origin: An optional override of the default origin specified in initialization. Follow a reverse-DNS syntax, i.e.
    ///  com.myco.myapp`.
    ///  - Returns: The TitleRecord with the specified ID, or `nil` if the record is not found.
    public static func getTitle(id: String, origin: String? = nil) async throws -> TitleRecord?{
        let rspTitle: RspTitle = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqTitle = ReqTitleGet(
                    id: id,
                    origin: origin
                )
                try instance._coreChannel.invokeMethod(
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
    
    /// Returns the LicenseRecord for a given ID or nil if the license or corresponding title record is not found.
    ///
    /// This method retrieves the LicenseRecord object that matches the specified ID. If no record is found, it returns nil. The `origin` parameter can be used to override the default origin specified in initialization.
    ///
    /// - Parameters
    ///     - id: The ID of the LicenseRecord to retrieve.
    ///     - origin: An optional override of the default origin specified in `initTikiSdkAsync`.
    /// - Returns: The LicenseRecord that matches the specified ID or nil if the license or corresponding title record is not found.
    public static func getLicense(id: String, origin: String? = nil) async throws -> LicenseRecord? {
        let rspLicense: RspLicense = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqLicense = ReqTitleGet(
                    id: id,
                    origin: origin
                )
                try instance._coreChannel.invokeMethod(
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
    /// Returns all LicenseRecords associated with a given Pointer Record.
    ///
    /// Use this method to retrieve all LicenseRecords that have been previously stored for a given Pointer Record in your system.
    ///
    /// - Parameters:
    ///    - ptr: The Pointer Record that identifies the data stored in your system, similar to a foreign key.
    ///    - origin: An optional origin. If nil, the origin defaults to the package name.
    /// - Returns: An array of all LicenseRecords associated with the given Pointer Record. If no LicenseRecords are found,
    /// an empty array is returned.
    public static func all(ptr: String, origin: String? = nil) async throws -> [LicenseRecord] {
        let rspAll: RspLicenseList = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqAll = ReqLicenseAll(
                    ptr: ptr,
                    origin: origin
                )
                try instance._coreChannel.invokeMethod(
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
    
    /// Returns the latest LicenseRecord for a ptr or nil if the corresponding title or license records are not found.
    /// - Parameters:
    ///    - ptr: The Pointer Records identifies data stored in your system, similar to a foreign key.
    ///    - origin: An optional origin. If nil, the origin defaults to the package name.
    ///
    /// - Returns: The latest LicenseRecord for the given ptr, or nil if the corresponding title or license records are not found.
    public static func latest(ptr: String, origin: String? = nil) async throws -> LicenseRecord? {
        let rspLicense: RspLicense = try await withCheckedThrowingContinuation{ continuation in
            do{
                let reqLicense = ReqLicenseLatest(
                    ptr: ptr,
                    origin: origin
                )
                try instance._coreChannel.invokeMethod(
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
    
    
    // MARK: Private properties
    
    private var _address: String?
    private var _dark: Theme?
    private var _onAccept: ((Offer, LicenseRecord) -> Void)?
    private var _onDecline: ((Offer, LicenseRecord?)  -> Void)?
    
    private var _onSettings: (() -> Void) = {try? TikiSdk.settings()}
    private var _isAcceptEndingDisabled = false
    private var _isDeclineEndingDisabled = false
    private var _offers = [String: Offer]()
    private var _theme = Theme()
    private var _coreChannel: CoreChannel = CoreChannel()
    
    // MARK: Private methods
    
    private init() {}
    
    private static func throwIfNotInitialized() throws{
        if(!TikiSdk.isInitialized){
            throw TikiSdkError(message: "Please ensure that the TIKI SDK is properly initialized by calling initialize().", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
    }
    
    private static func throwIfNoOffers() throws{
        if(TikiSdk.instance.offers.isEmpty) {
            throw TikiSdkError(message: "To proceed, kindly utilize the TikiSdk.offer() method to include at least one offer.", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
    }
}
