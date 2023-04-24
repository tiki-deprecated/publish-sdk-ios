/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import SwiftUI

/// An Offer represents usage terms and conditions for a particular `TitleRecord`. Offers can be used to create or update a
/// `LicenseRecord` in the pre-built UI.
public class Offer {
    
    // MARK: Instance properties
    
    /// The pointer record for the TitleRecord to which this Offer applies.
    ///
    /// This property is used to create or find the TitleRecord for which the Offer applies.
    public var ptr: String?
    
    /// A brief description of the Offer.
    ///
    /// This property is used to inform the user about the Offer, and is also used as the description for the `LicenseRecord`
    /// associated with this Offer.
    public var description: String?

    /// The legal terms and conditions of the Offer.
    ///
    /// Use this property to specify detailed legal terms and conditions for the usage of the TitleRecord associated with this Offer.
    /// It supports basic markdown formatting and hyperlinks.
    ///
    /// To set the terms, either:
    /// - set the property directly with the markdown text
    ///```
    ///         offer.terms = "# Legal Terms and Conditions\n\nBy using this product, you agree to the following terms and conditions."
    ///```
    /// - or use the `terms` method to load a markdown file:
    ///```
    ///         try offer.terms("terms.md")
    ///```
    ///- Note: The markdown file must be included in the app bundle if you use the `terms` method.
    ///
    ///- Warning: If the `terms` property is set manually, any previous markdown file
    /// loaded using the `terms` method will be overwritten.
    ///
    ///- Warning: The `terms` property must be set before calling the `add()` method, otherwise it will throw a `TikiSdkError`.
    public var terms: LocalizedStringKey?

    
    /// The Image that represents the Offer.
    ///
    /// This property is used to display a graphical representation of the Offer. For best results, it is recommended to provide images
    /// in multiple sizes to support different screen resolutions on iOS devices.
    ///
    /// You should provide 4 versions of the image, with the following dimensions and scale factors:
    ///
    /// * 1x: 300 x 86 pixels
    /// * 2x: 600 x 172 pixels
    /// * 3x: 900 x 258 pixels
    ///
    /// To provide the images, you can add them to an asset catalog by selecting "New Image Set" and setting the name to "offer-reward".
    /// Then, drag and drop the 1x, 2x, and 3x versions of the image into the asset catalog.
    ///
    /// Alternatively, you can provide the images with separate filenames, and use the Image(systemName:) method to refer to the appropriate
    /// image in your code. When naming your image files, append "@1x", "@2x", or "@3x" to the filename to indicate the scale factor.
    /// For example:
    ///
    /// * offer-reward@1x (300 x 86 pixels)
    /// * offer-reward@2x (600 x 172 pixels)
    /// * offer-reward@3x (900 x 258 pixels)
    ///
    /// To set the image, you can use the reward property setter or the `reward(_ reward: String)` method.
    ///
    /// - Set the image using the `reward` property
    /// ```
    /// offer.reward = Image(systemName: "offer-reward")
    /// ```
    /// - Set the image using the `reward(_:)` method
    /// ```
    /// offer.reward("offer-reward")
    /// ```
    /// Providing multiple versions of the image ensures that it looks sharp and clear on all iOS devices,
    /// regardless of their screen resolution.
    public var reward: Image?
    
    /// An array of Bullet objects that describe the data usage permissions included in this Offer, to be shown in the pre-built UI.
    ///
    /// Each bullet provides a concise description of how the user's data will be used under this Offer.
    ///
    /// It contains a `text` property which describes the data usage and an `isUsed` property which indicates
    /// whether the data is being used or not.
    ///
    /// It is recommended to use the `bullet(text:isUsed:)` method to manage the Offer bullets.
    /// This method adds a new `Bullet` object to the `bullets` array with the specified text and usage status, ensuring that the
    /// bullets are correctly initialized and avoiding any potential overrides.
    ///
    /// Additionally, this method returns the `Offer` object to enable convenient chaining of method calls during offer initialization.
    /// For example:
    ///
    /// ```
    /// offer
    ///  .bullet(text: "Your data will be used to personalize your experience", isUsed: true)
    ///  .bullet(text: "Your data will be shared with other companies", isUsed: false)
    /// ```
    ///
    /// Alternatively, you can initialize a new `Bullet` object manually and add it to the `bullets` array directly. For example:
    ///
    /// ```
    /// let bullet = Bullet(text: "Your data will be used to personalize your experience", isUsed: true)
    /// offer.bullets.append(bullet)
    /// ```
    ///
    /// It is important to provide clear and accurate descriptions of data usage in the bullets to help users understand how their data will
    /// be used under this Offer. It will be shown in the pre-built UI
    public var bullets = [Bullet]()
    
    /// An array of `LicenseUse` that apply to this `Offer`. Each `LicenseUse` specifies how the `TitleRecord`
    /// can be used under this Offer.
    ///
    /// It is recommended to use the `use(usecases:destinations:)` method to manage the Offer uses.
    /// This method adds a new `LicenseUse` object to the `uses` array with the specified usecases and destinations properties,
    /// ensuring that the `uses` array is correctly initialized and avoiding any potential overrides.
    ///
    /// Additionally, this method returns the Offer object to enable convenient chaining of method calls during offer initialization.
    /// For example:
    ///```
    /// offer
    ///  .use(usecases: [.attribution, .support], destinations: ["*.example.com"])
    ///  .use(usecases: [.attribution], destinations: ["*.myco.com"])
    ///```
    /// Alternatively, you can initialize a new LicenseUse object manually and add it to the uses array directly. For example:
    ///```
    /// let licenseUse = LicenseUse(usecases: [.attribition, .support], destinations: ["*.example.com"])
    /// offer.uses.append(licenseUse)
    ///```
    public var uses = [LicenseUse]()
    
    /// An array of `TitleTag` that apply to this `Offer`.
    ///
    /// Each `TitleTag` is a representation of a tag that describes a data asset within a the TitleRecord to which this offer refers.
    ///
    /// It is recommended to use the `tag(titletag:)` method to manage the Offer tags.
    /// This method adds a new `TitleTag` object to the `tags` array  ensuring that the `tags` array is correctly initialized and avoiding
    /// any potential overrides.
    ///
    /// Additionally, this method returns the Offer object to enable convenient chaining of method calls during offer initialization.
    /// For example:
    ///```
    /// offer
    ///  .tag(.advertisingData)
    ///  .tag(.creditInfo)
    ///```
    /// Alternatively, you can initialize a new TitleTag object manually and add it to the tags array directly.
    /// For example:
    ///```
    /// let tag = TitleTag.creditInfo
    /// offer.tags.append(tag)
    ///```
    public var tags = [TitleTag]()
    
    /// An array of `Permission`required for this `Offer`.
    ///
    /// It is recommended to use the `permission(_ permission:)` method to manage the Offer permissions.
    /// This method adds a new `Permission` object to the `permissions` array  ensuring that the `permissions` array is correctly initialized and avoiding
    /// any potential overrides.
    ///
    /// Additionally, this method returns the Offer object to enable convenient chaining of method calls during offer initialization.
    /// For example:
    ///```
    /// offer
    ///  .permission(.camera)
    ///  .permission(.microphone)
    ///```
    /// Alternatively, you can initialize a new Permission object manually and add it to the tags array directly.
    /// For example:
    ///```
    /// let permission = Permission.camera
    /// offer.permissions.append(permission)
    ///```
    public var permissions = [Permission]()
    
    /// The expiration date of the `LicenseRecord` applied to this `Offer`.
    ///
    /// If this property is set, the `LicenseRecord` associated with this `Offer` will expire on the specified date.
    ///
    /// It is recommended to use the public method `duration(_: TimeInterval) -> Offer` to set the expiry date
    /// based on the duration of the license, rather than setting it manually. This method calculates the expiry date by adding
    /// the specified time interval to the current date, and returns the `Offer` object to enable convenient chaining of method
    /// calls during offer initialization.
    ///
    /// If the expiry date is not set, the `LicenseRecord` associated with this `Offer` will never expire.
    public var expiry: Date?

    
    /// The unique identifier of the `Offer`.
    ///
    /// If an `id` was not defined with the id(_ id: String) method, a random UUID string will be generated and used as the `id`.
    public var id: String {
        if _id == nil {
            _id = UUID().uuidString
        }
        return _id!
    }

    // MARK: Instance methods
    
    /// Sets the unique identifier for this Offer.
    ///
    /// The `id` parameter must be a non-empty String that uniquely identifies the Offer.
    ///
    /// - Parameter id: A String representing the unique identifier for the Offer. Must not be `nil` or empty.
    /// - Returns: The modified Offer object.
    ///
    /// The `id` parameter is not set, a random UUID will be used when adding the Offer in TikiSdk.
    public func id(_ id: String) -> Offer {
        _id = id
        return self
    }
    
    /// Defines the image that represents the Offer.
    ///
    /// This method defines the image that will be used to ilustrate the Offer.
    ///
    /// For best results, it is recommended to provide images in multiple sizes to support different screen resolutions on
    /// iOS devices.
    ///
    /// You should provide 4 versions of the image, with the following dimensions and scale factors:
    ///
    /// * 1x: 300 x 86 pixels
    /// * 2x: 600 x 172 pixels
    /// * 3x: 900 x 258 pixels
    ///
    /// To provide the images, you can add them to an asset catalog by selecting "New Image Set" and setting the
    /// name to "offer-reward".
    ///
    /// Then, drag and drop the 1x, 2x, and 3x versions of the image into the asset catalog.
    ///
    /// Alternatively, you can provide the images with separate filenames, and use the Image(systemName:) method to refer to the
    /// appropriate
    /// image in your code. When naming your image files, append "@1x", "@2x", or "@3x" to the filename to indicate the scale
    /// factor.
    /// For example:
    ///
    /// * offer-reward@1x (300 x 86 pixels)
    /// * offer-reward@2x (600 x 172 pixels)
    /// * offer-reward@3x (900 x 258 pixels)
    ///
    /// To set the image, you can use the reward property setter or the `reward(_ reward: String)` method.
    ///
    /// - Set the image using the `reward(_:)` method
    /// ```
    /// offer.reward("offer-reward")
    /// ```
    /// Providing multiple versions of the image ensures that it looks sharp and clear on all iOS devices,
    /// regardless of their screen resolution.
    public func reward(_ reward: String) -> Offer {
        self.reward = Image(reward)
        return self
    }
    
    /// An array of Bullet objects that describe the data usage permissions included in this Offer, to be shown in the pre-built UI.
    ///
    /// Each bullet provides a concise description of how the user's data will be used under this Offer.
    ///
    /// It contains a `text` property which describes the data usage and an `isUsed` property which indicates
    /// whether the data is being used or not.
    ///
    public func bullet(text: String, isUsed: Bool) -> Offer {
        bullets.append(Bullet(text: text, isUsed: isUsed))
        return self
    }
    
    /// Sets the pointer record of the data asset associated to this Offer.
    public func ptr(_ ptr: String) -> Offer {
        self.ptr = ptr
        return self
    }
    
    /// Sets the description of the Offer.
    public func description(_ description: String?) -> Offer {
        self.description = description
        return self
    }
    
    /// Sets the file that contains legal terms and conditions of the Offer.
    ///
    /// Use this method to specify detailed legal terms and conditions for the usage of the TitleRecord associated with this Offer.
    /// It supports basic markdown formatting and hyperlinks.
    /// For example, if the filename is `terms.md`:
    /// ```
    ///         try offer.terms("terms.md")
    /// ```
    /// - Note: The markdown file must be included in the app bundle if you use the `terms` method.
    ///
    /// - Warning: The `terms` property must be set before calling the `add()` method, otherwise it will throw
    /// a `TikiSdkError`.
    public func terms(_ filename: String) throws -> Offer {
        terms = LocalizedStringKey(stringLiteral: try String(
            contentsOfFile: Bundle.main.path(forResource: filename, ofType: "md")!,
            encoding: String.Encoding(rawValue: NSUTF8StringEncoding)))
        return self
    }
    
    /// Adds a LicenceUse to the Offer.
    ///
    /// This method adds a new `LicenseUse` object to the `uses` array with the specified usecases and
    /// destinations properties, ensuring that the `uses` array is correctly initialized and avoiding any potential overrides.
    ///
    /// Additionally, this method returns the Offer object to enable convenient chaining of method calls during offer initialization.
    /// For example:
    ///```
    /// offer
    ///  .use(usecases: [.attribution, .support], destinations: ["*.example.com"])
    ///  .use(usecases: [.attribution], destinations: ["*.myco.com"])
    ///```
    public func use(usecases: [LicenseUsecase], destinations: [String]? = []) -> Offer {
        uses.append(LicenseUse(usecases: usecases, destinations: destinations))
        return self
    }
    
    /// Adds a `TitleTag` that describe the data atached to this `Offer`.
    ///
    /// This method adds a new `TitleTag` object to the `tags` array  ensuring that the `tags` array is correctly
    /// initialized and avoiding any potential overrides.
    ///
    /// Additionally, this method returns the Offer object to enable convenient chaining of method calls during offer initialization.
    /// For example:
    ///```
    /// offer
    ///  .tag(.advertisingData)
    ///  .tag(.creditInfo)
    ///```
    public func tag(_ tag: TitleTag) -> Offer {
        tags.append(tag)
        return self
    }
    
    /// Determine the duartion of the `LicenseRecord` applied to this `Offer`.
    ///
    /// This method calculates the `LicenseRecord.expiry` date by adding the specified time interval to the current date,
    /// and returns the `Offer` object to enable convenient chaining of method calls during offer initialization.
    public func duration(_ timeInterval: TimeInterval) -> Offer {
        let now: Int = Int(Date().timeIntervalSince1970)
        expiry = Date(timeIntervalSince1970: Double(now)).addingTimeInterval(timeInterval)
        return self
    }
    
    /// Adds a new required `Permission` for this `Offer`.
    ///
    /// This method adds a new `Permission` object to the `permissions` array  ensuring that the `permissions`
    /// array is correctly initialized and avoiding any potential overrides.
    ///
    /// It returns the Offer object to enable convenient chaining of method calls during offer initialization.
    /// For example:
    ///```
    /// offer
    ///  .permission(.camera)
    ///  .permission(.microphone)
    ///```
    ///
    /// - Returns: the Offer object to enable convenient chaining of method calls during offer initialization.
    public func permission(_ permission: Permission) -> Offer {
        permissions.append(permission)
        return self
    }
    
    /// Adds this offer to the TikiSdk
    public func add() throws -> TikiSdk  {
        if (ptr == nil) {
            throw TikiSdkError(message: "Set the Offer pointer record (ptr).", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        if (uses.isEmpty) {
            throw TikiSdkError(message: "Add at lease one License use case to the Offer.", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        if(terms == nil){
            throw TikiSdkError(message: "Set the Offer terms.", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        return TikiSdk.instance.addOffer(self)
    }
    
    // MARK: Private properties
    private var _id: String?
}
