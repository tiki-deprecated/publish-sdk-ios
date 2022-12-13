import Flutter

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
public class TikiSdk{
    
    var continuations: Dictionary<String, CheckedContinuation<String, Error>> = [:]
    var tikiSdkFlutterChannel: TikiSdkFlutterChannel
    var methodChannel: FlutterMethodChannel
    
    public var address: String?
    
    /// Initialized the TIKI SDK.
    ///
    /// - Parameters:
    ///     - origin: The default *origin* for all transactions.
    ///     - apiId: The *apiId* for connecting to TIKI cloud.
    ///
    /// - Throws: *TikiSdkError*
    public init(origin: String, apiId: String, address: String? = nil) async throws{
        tikiSdkFlutterChannel = TikiSdkFlutterChannel(apiId: apiId, origin: origin, address: address)
        methodChannel = tikiSdkFlutterChannel.methodChannel
        tikiSdkFlutterChannel.tikiSdk = self;
        self.address = try await withCheckedThrowingContinuation { continuation in
            continuations["build"] = continuation
        }
    }
    
    /// Assign ownership to a given *source*.
    ///
    /// - Parameters:
    ///    - source: The identification of the data *source*.
    ///    - type: The *type* of data source (point, pool or stream) identified by *TikiSdkDataTypeEnum*.
    ///    - contains: The list of items the data *contains*.
    ///    - about: A description about the data.
    ///    - origin: Optional override for default origin.
    ///
    /// - Returns:A base64 url-safe no-padding representation of the ownership transaction id.
    /// - Throws: *TikiSdkError*
    public func assignOwnership(
        source: String,
        type: TikiSdkDataTypeEnum,
        contains: Array<String>,
        about: String? = nil,
        origin: String? = nil
    ) async throws -> String {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "assignOwnership", arguments: [
                "requestId" : requestId,
                "source" : source,
                "type" : type.rawValue,
                "contains" : contains,
                "about" : about as Any,
                "origin" : origin as Any
            ])
        return try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
    }
    
    /// Gets the ownership for a *source*.
    ///
    /// - Parameters:
    ///    - source: The identification of the data *source*.
    ///    - origin: Optional override for default origin.
    /// - Returns: *TikiSdkOwnership*
    /// - Throws: *TikiSdkError*
    public func getOwnership(
        source : String,
        origin : String? = nil
    ) async throws -> TikiSdkOwnership{
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "getOwnership", arguments: [
                "requestId" : requestId,
                "source" : source,
                "origin" : origin as Any
            ])
        let jsonOwnership = try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
        return TikiSdkOwnership.fromJson(jsonString: jsonOwnership)
    }
    
    /// Modify consent for an ownership identified by [ownershipId].
    ///
    /// The Ownership must be granted before modifying consent. Consent is applied
    /// on an explicit only basis. Meaning all requests will be denied by default
    /// unless the destination is explicitly defined in *destination*.
    /// A blank list of *TikiSdkDestination.uses* or *TikiSdkDestination.paths*
    /// means revoked consent.
    ///
    /// - Parameters
    ///     - ownershipId: The transaction id of the ownership registry.
    ///     - destination: *TikiSdkDestination*.
    ///     - about: A description about the data.
    ///     - reward: An optional reward the user will receive for granting consent.
    ///     - expiry: The consent expiration date.
    ///
    /// - Returns: The created *TikiSdkConsent*.
    /// - Throws: *TikiSdkError*
    public func modifyConsent(
        ownershipId: String,
        destination: TikiSdkDestination,
        about: String? = nil,
        reward: String? = nil,
        expiry: Date? = nil
    ) async throws -> TikiSdkConsent {
        let requestId = UUID().uuidString
        var expiration = expiry?.timeIntervalSince1970
        if(expiration != nil){
            expiration! *= 1000
        }
        methodChannel.invokeMethod(
            "modifyConsent", arguments: [
                "requestId" : requestId,
                "ownershipId" : ownershipId,
                "destination" : destination.toJson(),
                "about" : about as Any,
                "reward" : reward as Any,
                "expiry" : expiration as Any
            ]
        )
        let jsonConsent = try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
        return TikiSdkConsent.fromJson(jsonString: jsonConsent);
    }
    
    /// Gets latest consent given for a *source* and *origin*.
    ///
    /// It does not validate if the consent is expired or if it can be applied to
    /// a specific destination. For that, *applyConsent* should be used instead.
    /// If no *origin* is specified, it uses the default origin.
    ///
    /// - Parameters
    ///     - source: The identification of the data *source*.
    ///     - destination: *TikiSdkDestination*.
    ///     - origin: Optional override for default origin.
    ///
    /// - Returns: Latest *TikiSdkConsent* for *source* and *origin*.
    /// - Throws: *TikiSdkError*
    public func getConsent(
        source: String,
        origin: String? = nil
    ) async throws -> TikiSdkConsent {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "getConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "origin" : origin as Any
            ]
        )
        let jsonConsent = try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
        return TikiSdkConsent.fromJson(jsonString: jsonConsent);
    }
    
    /// Apply consent for a given *source* and *destination*.
    ///
    /// If consent exists for the destination and is not expired, *request* will be
    /// executed. Else *onBlocked* is called.
    ///
    /// - Parameters
    ///     - source: The identification of the data *source*.
    ///     - destination: *TikiSdkDestination*.
    ///     - request: The function to run if the consent is given.
    ///     - onBlocked: The function to run if the consent is not given.
    ///    - origin: Optional override for default origin.
    public func applyConsent(
        source: String,
        destination: TikiSdkDestination,
        request:  (() -> Void),
        onBlocked:  ((String) -> Void)?,
        origin: String? = nil
    ) async -> Void {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "applyConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "destination" : destination.toJson(),
                "origin" : origin as Any
            ]
        )
        do{
            try await withCheckedThrowingContinuation { continuation in
                continuations[requestId] = continuation
            }
            request();
        }catch {
            onBlocked?(error.localizedDescription)
        }
    }
}
