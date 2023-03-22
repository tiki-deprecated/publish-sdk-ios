/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

struct RspLicenseList: Decodable{
    let licenseList: [LicenseRecord]
}
