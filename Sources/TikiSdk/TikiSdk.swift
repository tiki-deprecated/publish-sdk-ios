import Flutter
import FlutterPluginRegistrant

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
public class TikiSdk{
    
    var continuations: Dictionary<String, CheckedContinuation<String, Error>> = [:]
    var tikiSdkFlutterChannel: TikiSdkFlutterChannel = TikiSdkFlutterChannel()
    var methodChannel: FlutterMethodChannel? = nil
    
    public var address: String? = nil
    var origin: String? = nil
    
    /// Initializes the TIKI SDK.
    ///
    /// - Parameters:
    ///     - origin: The default *origin* for all transactions.
    ///     - apiId: The *apiId* for connecting to TIKI cloud.
    ///
    /// - Throws: *TikiSdkError*
    public init(origin: String, apiId: String, address: String? = nil) async throws{
        DispatchQueue.main.async {
            let buildRequest = ReqBuild(requestId: "build", apiId: apiId, origin: origin, address: address)
            let flutterEngine: FlutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
            flutterEngine.run()
            GeneratedPluginRegistrant.register(with: flutterEngine);
            self.tikiSdkFlutterChannel.methodChannel = FlutterMethodChannel.init(name: TikiSdkFlutterChannel.channelId, binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
            self.tikiSdkFlutterChannel.methodChannel!.setMethodCallHandler(self.tikiSdkFlutterChannel.handle)
            self.tikiSdkFlutterChannel.tikiSdk = self
            self.tikiSdkFlutterChannel.methodChannel!.invokeMethod(
                "build", arguments: [ "request": buildRequest.toJson() ]
            )
            self.methodChannel = self.tikiSdkFlutterChannel.methodChannel
        }
        let response: String = try await withCheckedThrowingContinuation { continuation in
            continuations["build"] = continuation
        }
        let rspBuild = try JSONDecoder().decode(RspBuild.self, from:  Data(response.utf8))
        self.address = rspBuild.address
        self.origin = origin
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
        let assignReq = ReqOwnershipAssign(
            requestId: requestId, source: source, type: type, contains: contains, about: about, origin: origin ?? origin)
        self.methodChannel!.invokeMethod(
            "assignOwnership", arguments: [
                "request" : assignReq.toJson()
            ])
        let response: String = try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
        let rspOwnership = try JSONDecoder().decode(RspOwnership.self, from:  Data(response.utf8))
        return rspOwnership.ownership.transactionId
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
        let getReq = ReqOwnershipGet(requestId: requestId, source: source, origin: origin ?? self.origin)
        methodChannel!.invokeMethod(
            "getOwnership", arguments: [
                "request" : getReq.toJson()
            ])
        let response: String = try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
        let rspOwnership = try JSONDecoder().decode(RspOwnership.self, from:  Data(response.utf8))
        return rspOwnership.ownership
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
    ) async throws -> TikiSdkConsent? {
        let requestId = UUID().uuidString
        let modifyReq = ReqConsentModify(requestId: requestId, ownershipId: ownershipId, destination: destination)
        methodChannel!.invokeMethod(
            "modifyConsent", arguments: [
                "request" : modifyReq.toJson()
            ])
        let response: String = try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
        let rspConsent = try JSONDecoder().decode(RspConsentGet.self, from:  Data(response.utf8))
        return rspConsent.consent
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
    ) async throws -> TikiSdkConsent? {
        let requestId = UUID().uuidString
        let getReq = ReqConsentGet(requestId: requestId, source: source, origin: origin ?? self.origin)
        methodChannel!.invokeMethod(
            "getConsent", arguments: [
                "request" : getReq.toJson()
            ])
        let response: String = try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
        let rspConsent = try JSONDecoder().decode(RspConsentGet.self, from:  Data(response.utf8))
        return rspConsent.consent
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
        onBlocked:  ((String) -> Void)? = nil,
        origin: String? = nil
    ) async throws -> Void {
        let requestId = UUID().uuidString
        let reqApply = ReqConsentApply(requestId: requestId, source: source, destination: destination, origin: origin ?? self.origin)
        methodChannel!.invokeMethod(
            "applyConsent",  arguments: [
                "request" : reqApply.toJson()
            ]
        )
        let response: String = try await withCheckedThrowingContinuation { continuation in
            continuations[requestId] = continuation
        }
        let rspConsentApply = try JSONDecoder().decode(RspConsentApply.self, from:  Data(response.utf8))
        if(rspConsentApply.success){
            request();
        }else{
            onBlocked?(rspConsentApply.reason ?? "no consent")
        }
    }
}
