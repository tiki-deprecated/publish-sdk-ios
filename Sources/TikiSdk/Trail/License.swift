/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation

class License{
    
    let channel: Channel
    
    init(channel: Channel){
        self.channel = channel
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
    ///   - uses: A list defining how and where an asset may be used, in the format of `Use` objects. Learn more about specifying
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
    public func create(
            titleId: String,
            uses: [Use],
            terms: String,
            expiry: Date? = nil,
            description: String? = nil,
            completion: ((LicenseRecord?) ->  Void)? = nil) async throws -> LicenseRecord?
    {
        let licenseReq = ReqLicense(titleId: titleId, uses: uses, terms: terms, expiry: expiry, description: description)
        let rspLicense: RspLicense = try await channel.request(
            method: TrailMethod.LICENSE_CREATE,
            request: licenseReq) { rsp in
                let rspLicense = RspLicense(from: rsp)
                return rspLicense
            }
        let license = LicenseRecord(from: rspLicense)
        completion?(license)
        return license
    }
    
    
    /// Returns the LicenseRecord for a given ID or nil if the license or corresponding title record is not found.
    ///
    /// This method retrieves the LicenseRecord object that matches the specified ID. If no record is found, it returns nil. The `origin` parameter can be used to override the default origin specified in initialization.
    ///
    /// - Parameters
    ///     - id: The ID of the LicenseRecord to retrieve.
    ///     - origin: An optional override of the default origin specified in `initTikiSdkAsync`.
    /// - Returns: The LicenseRecord that matches the specified ID or nil if the license or corresponding title record is not found.
    public func get(id: String, completion: ((LicenseRecord?) -> Void)? = nil) async throws -> LicenseRecord? {
        let licenseReq = ReqLicenseGet(id: id)
        let rspLicense: RspLicense = try await channel.request(
            method: TrailMethod.LICENSE_GET,
            request: licenseReq) { rsp in
                let rspLicense = RspLicense(from: rsp)
                return rspLicense
            }
        let license = LicenseRecord(from: rspLicense)
        completion?(license)
        return license
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
    public func all(
        titleId: String,
        completion: (([LicenseRecord]) -> Void)? = nil
    ) async throws -> [LicenseRecord] {
        let licenseReq = ReqLicenseAll(titleId: titleId)
        let rspLicenses: RspLicenses = try await channel.request(
            method: TrailMethod.LICENSE_ALL,
            request: licenseReq) { rsp in
                let rspLicenses = RspLicenses(from: rsp)
                return rspLicenses
            }
        let licenseAll: [LicenseRecord] = rspLicenses.licenses == nil ? [] :
            (rspLicenses.licenses! as [RspLicense]).map{ LicenseRecord(from: $0)! }
        completion?(licenseAll)
        return licenseAll
    }
    
}
