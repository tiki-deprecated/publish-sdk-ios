import Flutter

/// The completion type for TikiSdkFlutterChannelCalls
public typealias TikiSdkCompletion = (_ success: Bool, _ response: String?) -> Void

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
public class TikiSdk{
    var completions: Dictionary<String, TikiSdkCompletion> = [:]
    var continuations: Dictionary<String, CheckedContinuation<String, Never>> = [:]
    var tikiSdkFlutterChannel: TikiSdkFlutterChannel
    var methodChannel: FlutterMethodChannel
    var address: String?

    /// Initialized the TIKI SDK.
    ///
    /// - Parameters:
    ///     - origin: The default *origin* for all transactions.
    ///     - apiId: The *apiId* for connecting to TIKI cloud.
    public init(origin: String, apiId: String) async {
        tikiSdkFlutterChannel = TikiSdkFlutterChannel(apiId: apiId, origin: origin)
        methodChannel = tikiSdkFlutterChannel.methodChannel
        tikiSdkFlutterChannel.tikiSdk = self;
        address = await withCheckedContinuation { continuation in
                continuations["build"] = continuation
        }
    }

    /// Assign ownership to a given *source*.
    ///
    /// - Parameters:
    ///    - source: String,
    ///    - type: String,
    ///    - contains: The list of items the data contains is described by [contains]
    ///    - about:
    ///    - completion: @escaping TikiSdkCompletion,
    ///    - origin: String? = nil
    ///
    /// - Returns:A base64 url-safe representation of the ownership transaction id.
    public func assignOwnership(
        source: String,
        type: String,
        contains: Array<String>,
        about: String,
        origin: String? = nil
    ) async -> String {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "assignOwnership", arguments: [
                "requestId" : requestId,
                "source" : source,
                "type" : type,
                "contains" : contains,
                "origin" : origin as Any
            ])
        return await withCheckedContinuation { continuation in
                continuations[requestId] = continuation
        }
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
    ///     - source: String,
    ///     - destination: TikiSdkDestination,
    ///     - completion: @escaping TikiSdkCompletion,
    ///     - about: String? = nil,
    ///     - reward: String? = nil
    ///     - expiry
    ///
    ///  - Returns: The created *TikiSdkConsent*.
    public func modifyConsent(
        source: String,
        destination: TikiSdkDestination,
        completion: @escaping TikiSdkCompletion,
        about: String? = nil,
        reward: String? = nil,
        expiry: Date
    ) async -> String {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "modifyConsent", arguments: [
                "requestId" : requestId,
                "source" : source,
                "destination" : destination.toJson(),
                "about" : about,
                "reward" : reward,
                ]
        )
        return await withCheckedContinuation { continuation in
                continuations[requestId] = continuation
        }
    }

    /// Gets latest consent given for a *source* and *origin*.
    ///
    /// It does not validate if the consent is expired or if it can be applied to
    /// a specific destination. For that, *applyConsent* should be used instead.
    /// If no *origin* is specified, it uses the default origin.
    ///
    /// - Parameters
    ///     - source
    ///     - destination
    ///
    /// - Returns: Latest *TikiSdkConsent* for *source* and *origin*.
    public func getConsent(
        source: String,
        completion: @escaping TikiSdkCompletion,
        origin: String? = nil
    ) async -> String {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "getConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "origin" : origin as Any
            ]
        )
        return await withCheckedContinuation { continuation in
                continuations[requestId] = continuation
        }
    }
    
    /// Apply consent for a given *source* and *destination*.
    ///
    /// If consent exists for the destination and is not expired, *request* will be
    /// executed. Else *onBlocked* is called.
    ///
    /// - Parameters
    ///     - source
    ///     - destination
    ///     - request
    ///     - onBlock
    ///     - origin
    public func applyConsent(
        source: String,
        destination: TikiSdkDestination,
        request:  @escaping (String?) -> Void,
        onBlock:  @escaping (String?) -> Void,
        origin: String
    ) async -> String {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "applyConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "destination" : destination.toJson(),
            ]
        )
        return await withCheckedContinuation { continuation in
                continuations[requestId] = continuation
        }
    }
}
