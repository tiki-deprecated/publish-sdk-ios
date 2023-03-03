/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Flutter
import UIKit

/// An Offer for creating a License for a Title identified by [ptr].
class Offer {
    var _id: String?
    var _ptr: String?
    var _description: String?
    var _terms: String?
    var _reward: UIImage?
    var _usedBullet = [UsedBullet]()
    var _uses = [String]()
    var _tags = [String]()
    var _requiredPermissions = [String]()
    var _expiry: Date?
    
    /// The Offer unique identifier. If none is set, it creates a random UUID.
    var id: String {
        if(_id == nil){
            _id = UUID().uuidString
        }
        return _id!
    }
    
    /// An image that represents the reward.
    ///
    /// It should have 300x86 size and include assets for all screen depths.
    var reward: UIImage? {
        _reward
    }
    
    /// The bullets that describes how the user data will be used.
    var usedBullet: [UsedBullet] {
        _usedBullet
    }
    
    /// The Pointer Record of the data stored.
    var ptr: String {
        _ptr!
    }
    
    /// A human-readable description for the license.
    var description: String? {
        _description
    }
    
    /// The legal terms of the offer.
    var terms: String? {
        _terms
    }
    
    /// The Use cases for the license.
    var uses: [String] {
        _uses
    }
    
    /// The tags that describes the represented data asset.
    var tags: [String] {
        _tags
    }
    
    /// The expiration of the License. Null for no expiration.
    var expiry: Date? {
        _expiry
    }
    
    /// A list of device-specific [Permission] required for the license.
    var requiredPermissions: [String] {
        _requiredPermissions
    }
    
    /// Sets the [id]
    func setId(_ id: String) -> Offer {
        _id = id
        return self
    }
    
    /// Sets the [reward]
    func setReward(_ reward: UIImage) -> Offer {
        _reward = reward
        return self
    }
    
    /// Sets the [usedBullet]
    func setUsedBullet(_ usedBullet: [UsedBullet]) -> Offer {
        _usedBullet = usedBullet
        return self
    }
    
    /// Adds a [usedBullet]
    func addUsedBullet(_ usedBullet: UsedBullet) -> Offer {
        _usedBullet.append(usedBullet)
        return self
    }
    
    /// Sets the [ptr]
    func setPtr(_ ptr: String) -> Offer {
        _ptr = ptr
        return self
    }
    
    /// Sets the [description]
    func setDescription(_ description: String) -> Offer {
        _description = description
        return self
    }
    
    /// Sets the [terms]
    func setTerms(_ terms: String) -> Offer {
        _terms = terms
        return self
    }
    
    /// Sets the [uses]
    func setUses(_ uses: [String]) -> Offer {
        _uses = uses
        return self
    }
    
    /// Adds an item in the [uses] list.
    func addUse(_ use: String) -> Offer {
        _uses.append(use)
        return self
    }
    
    /// Sets the [tags]
    func setTags(_ tags: [String]) -> Offer {
        _tags = tags
        return self
    }
    
    /// Adds an item in the [tags
    func addTag(_ tag: String) -> Offer {
        _tags.append(tag)
        return self
    }
    
    /// Sets the [expiry]
    func setExpiry(expiry: Date) -> Offer {
        _expiry = expiry
        return self
    }
    
    /// Sets the [requiredPermissions]
    func setReqPermissions(permissions: [String]) -> Offer {
        _requiredPermissions = permissions
        return self
    }
    
    /// Adds an item in the [requiredPermissions] list.
    func addReqPermission(permission: String) -> Offer {
        _requiredPermissions.append(permission)
        return self
    }
    
    /// Adds the built Offer to the [TikiSdk.offers] list
    func add() throws -> TikiSdk  {
        if (_ptr == nil) {
            throw TikiSdkError(message: "Set the Offer pointer record (ptr).", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        if (_uses.isEmpty) {
            throw TikiSdkError(message: "Add at lease one License use case to the Offer.", stackTrace: Thread.callStackSymbols.joined(separator: "\n"))
        }
        return TikiSdk.instance.addOffer(self)
    }
}
