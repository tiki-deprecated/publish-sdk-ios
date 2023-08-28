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
    
    var idp: Idp {
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
    
    
    var trail: Trail {
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
            let ptr : String = TikiSdk.instance.offers.values.first!.ptr!
            var usecases: [Usecase] = []
            var destinations: [String] = []
            TikiSdk.instance.offers.values.first!.uses.forEach{ licenseUse in
                if(licenseUse.destinations != nil){
                    destinations.append(contentsOf: licenseUse.destinations!)
                }
                usecases.append(contentsOf: licenseUse.usecases)
            }
        let _ = try instance.trail.guard(ptr: ptr, usecases: usecases, destinations: destinations, onFail: {_ in presentOffer()
        })
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
    
    // MARK: Private properties
    
    private var _address: String?
    private var _id: String?
    private var _dark: Theme?
    private var _onAccept: ((Offer, LicenseRecord) -> Void)?
    private var _onDecline: ((Offer, LicenseRecord?)  -> Void)?
    
    private var _onSettings: (() -> Void) = {try? TikiSdk.settings()}
    private var _isAcceptEndingDisabled = false
    private var _isDeclineEndingDisabled = false
    private var _offers = [String: Offer]()
    private var _theme = Theme()
    
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
    
    private static func throwIfNoOffers() throws{
        if(TikiSdk.instance.offers.isEmpty) {
            throw TikiSdkError(message: "To proceed, kindly utilize the TikiSdk.offer() method to include at least one offer.", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
    }
}
