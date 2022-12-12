import Flutter
import Darwin

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
    public init(origin: String, apiId: String) async throws{
        tikiSdkFlutterChannel = TikiSdkFlutterChannel(apiId: apiId, origin: origin)
        methodChannel = tikiSdkFlutterChannel.methodChannel
        tikiSdkFlutterChannel.tikiSdk = self;
        address = try await withCheckedThrowingContinuation { (continuation : CheckedContinuation<String, Error> ) in
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
    ) async throws -> String {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "assignOwnership", arguments: [
                "requestId" : requestId,
                "source" : source,
                "type" : type,
                "contains" : contains,
                "origin" : origin as Any
            ])
        return try await withCheckedThrowingContinuation { continuation in
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
    ///     - about: String? = nil,
    ///     - reward: String? = nil
    ///     - expiry
    ///
    ///  - Returns: The created *TikiSdkConsent*.
    public func modifyConsent(
        source: String,
        destination: TikiSdkDestination,
        about: String? = nil,
        reward: String? = nil,
        expiry: Date
    ) async throws -> String {
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
        return try await withCheckedThrowingContinuation { continuation in
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
        origin: String? = nil
    ) async throws -> String {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "getConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "origin" : origin as Any
            ]
        )
        return try await withCheckedThrowingContinuation { continuation in
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
    ) async -> Void {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "applyConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "destination" : destination.toJson(),
            ]
        )
        do{
            let response = try await withCheckedThrowingContinuation { continuation in
                continuations[requestId] = continuation
            }
            request(response);
        }catch {
            onBlock(error.localizedDescription)
        }
    }
}
