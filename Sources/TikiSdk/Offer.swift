/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import UIKit

/// An Offer for creating a License for a Title identified by [ptr].
public class Offer {
    private var _id: String?
    private var _ptr: String?
    private var _description: String?
    private var _terms: String?
    private var _reward: UIImage?
    private var _usedBullet = [UsedBullet]()
    private var _uses = [String]()
    private var _tags = [String]()
    private var _requiredPermissions = [String]()
    private var _expiry: Date?
    
    /// The Offer unique identifier. If none is set, it creates a random UUID.
    public var id: String {
        if(_id == nil){
            _id = UUID().uuidString
        }
        return _id!
    }
    
    /// An image that represents the reward.
    ///
    /// It should have 300x86 size and include assets for all screen depths.
    public var reward: UIImage? {
        _reward
    }
    
    /// The bullets that describes how the user data will be used.
    public var usedBullet: [UsedBullet] {
        _usedBullet
    }
    
    /// The Pointer Record of the data stored.
    public var ptr: String {
        _ptr!
    }
    
    /// A human-readable description for the license.
    public var description: String? {
        _description
    }
    
    /// The legal terms of the offer.
    public var terms: String? {
        _terms
    }
    
    /// The Use cases for the license.
    public var uses: [String] {
        _uses
    }
    
    /// The tags that describes the represented data asset.
    public var tags: [String] {
        _tags
    }
    
    /// The expiration of the License. Null for no expiration.
    public var expiry: Date? {
        _expiry
    }
    
    /// A list of device-specific [Permission] required for the license.
    public var requiredPermissions: [String] {
        _requiredPermissions
    }
    
    /// Sets the [id]
    public func setId(_ id: String) -> Offer {
        _id = id
        return self
    }
    
    /// Sets the [reward]
    public func setReward(_ reward: UIImage) -> Offer {
        _reward = reward
        return self
    }
    
    /// Sets the [usedBullet]
    public func setUsedBullet(_ usedBullet: [UsedBullet]) -> Offer {
        _usedBullet = usedBullet
        return self
    }
    
    /// Adds a [usedBullet]
    public func addUsedBullet(_ usedBullet: UsedBullet) -> Offer {
        _usedBullet.append(usedBullet)
        return self
    }
    
    /// Sets the [ptr]
    public func setPtr(_ ptr: String) -> Offer {
        _ptr = ptr
        return self
    }
    
    /// Sets the [description]
    public func setDescription(_ description: String) -> Offer {
        _description = description
        return self
    }
    
    /// Sets the [terms]
    public func setTerms(_ terms: String) -> Offer {
        _terms = terms
        return self
    }
    
    /// Sets the [uses]
    public func setUses(_ uses: [String]) -> Offer {
        _uses = uses
        return self
    }
    
    /// Adds an item in the [uses] list.
    public func addUse(_ use: String) -> Offer {
        _uses.append(use)
        return self
    }
    
    /// Sets the [tags]
    public func setTags(_ tags: [String]) -> Offer {
        _tags = tags
        return self
    }
    
    /// Adds an item in the [tags
    public func addTag(_ tag: String) -> Offer {
        _tags.append(tag)
        return self
    }
    
    /// Sets the [expiry]
    public func setExpiry(expiry: Date) -> Offer {
        _expiry = expiry
        return self
    }
    
    /// Sets the [requiredPermissions]
    public func setReqPermissions(permissions: [String]) -> Offer {
        _requiredPermissions = permissions
        return self
    }
    
    /// Adds an item in the [requiredPermissions] list.
    public func addReqPermission(permission: String) -> Offer {
        _requiredPermissions.append(permission)
        return self
    }
    
    /// Adds the built Offer to the [TikiSdk.offers] list
    public func add() throws -> TikiSdk  {
        if (_ptr == nil) {
            throw TikiSdkError(message: "Set the Offer pointer record (ptr).", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        if (_uses.isEmpty) {
            throw TikiSdkError(message: "Add at lease one License use case to the Offer.", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        return TikiSdk.instance.addOffer(self)
    }
}
