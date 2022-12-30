/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

/// The type of data origin for an ownership registry.
public enum MethodEnum: String, Codable{
    case BUILD  = "build"
    case ASSIGN_OWNERSHIP = "assignOwnership"
    case GET_OWNERSHIP = "getOwnership"
    case MODIFY_CONSENT = "modifyConsent"
    case GET_CONSENT = "getConsent"
    case APPLY_CONSENT = "applyConsent"
}
