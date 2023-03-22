/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import SwiftUI

/// An Offer for creating a License for a Title identified by [ptr].
public class Offer {
    /// An image that represents the reward.
    ///
    /// It should have 300x86 size and include assets for all screen depths.
   
    
    /// The bullets that describes how the user data will be used.
    
    /// The Pointer Record of the data stored.
    
    /// A human-readable description for the license.
    
    /// The legal terms of the offer.
    
    /// The Use cases for the license.
    
    /// The tags that describes the represented data asset.
    
    /// The expiration of the License. Null for no expiration.
    
    /// A list of device-specific [Permission] required for the license.
    
    public var _id: String?
    public var ptr: String?
    public var description: String?
    public var terms: String?
    public var reward: Image?
    public var usedBullet = [Bullet]()
    public var uses = [LicenseUse]()
    public var tags = [TitleTag]()
    public var permissions = [Permission]()
    public var expiry: Date?
    
    /// The Offer unique identifier. If none is set, it creates a random UUID.
    public var id: String {
        if(_id == nil){
            _id = UUID().uuidString
        }
        return _id!
    }
    
    /// Sets the [id]
    public func id(_ id: String) -> Offer {
        _id = id
        return self
    }
    
    /// Sets the [reward]
    public func reward(_ reward: String) -> Offer {
        self.reward = Image(reward)
        return self
    }
    
    /// Adds a [usedBullet]
    public func bullet(text: String, isUsed: Bool) -> Offer {
        usedBullet.append(Bullet(text: text, isUsed: isUsed))
        return self
    }
    
    /// Sets the [ptr]
    public func ptr(_ ptr: String) -> Offer {
        self.ptr = ptr
        return self
    }
    
    /// Sets the [description]
    public func description(_ description: String?) -> Offer {
        self.description = description
        return self
    }
    
    /// Sets the [terms]
    public func terms(_ filename: String) throws -> Offer {
        terms = try String(
            contentsOfFile: Bundle.main.path(forResource: filename, ofType: "md")!,
            encoding: String.Encoding(rawValue: NSUTF8StringEncoding))
        return self
    }
    
    /// Adds an item in the [uses] list.
    public func use(usecases: [LicenseUsecase], destinations: [String]? = []) -> Offer {
        uses.append(LicenseUse(usecases: usecases, destinations: destinations))
        return self
    }
    
    /// Adds an item in the [tags
    public func tag(_ tag: TitleTag) -> Offer {
        tags.append(tag)
        return self
    }
    
    /// Sets the [expiry] based in the *timeInterval*
    public func duration(_ timeInterval: TimeInterval) -> Offer {
        let now: Int = Int(Date().timeIntervalSince1970)
        expiry = Date(timeIntervalSince1970: Double(now)).addingTimeInterval(timeInterval)
        return self
    }
    
    /// Adds an item in the [requiredPermissions] list.
    public func permission(_ permission: Permission) -> Offer {
        permissions.append(permission)
        return self
    }
    
    /// Adds the built Offer to the [TikiSdk.offers] list
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
}
