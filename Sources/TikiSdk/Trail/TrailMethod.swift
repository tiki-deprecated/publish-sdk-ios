/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

enum TrailMethod: String, ChannelMethod {
    case IS_INITIALIZED = "trail.isInitialized"
    case ADDRESS = "trail.address"
    case ID = "trail.id"
    case GUARD = "trail.guard"
    case TITLE_CREATE = "trail.title.create"
    case TITLE_GET = "trail.title.get"
    case TITLE_ID = "trail.title.id"
    case LICENSE_CREATE = "trail.license.create"
    case LICENSE_ALL = "trail.license.all"
    case LICENSE_GET = "trail.license.get"
    case PAYABLE_CREATE = "trail.payable.create"
    case PAYABLE_ALL = "trail.payable.all"
    case PAYABLE_GET = "trail.payable.get"
    case RECEIPT_CREATE = "trail.receipt.create"
    case RECEIPT_ALL = "trail.receipt.all"
    case RECEIPT_GET = "trail.receipt.get"
    
    func value() -> String {
        return self.rawValue
    }
}
