import Flutter
import FlutterPluginRegistrant

/// The TIKI SDK main class. Use this to add tokenized data ownership, consent, and rewards.
public class TikiSdk{
    
    var tikiPlatformChannel: TikiPlatformChannel = TikiPlatformChannel()
    public var address: String? = nil
    
    /// Initializes the TIKI SDK.
    ///
    /// - Parameters:
    ///     - origin: The default *origin* for all transactions.
    ///     - apiId: The *apiId* for connecting to TIKI cloud.
    ///     - address: The *address* of the user node in TIKI blockchain. If null a new address will be created.
    ///
    /// - Throws: *TikiSdkError*
    public init(origin: String, apiId: String, address: String? = nil) async throws{
        self.tikiPlatformChannel.channel = await withCheckedContinuation{(continuation: CheckedContinuation<FlutterMethodChannel, Never>) in
            DispatchQueue.main.async {
                let flutterEngine: FlutterEngine = FlutterEngine(name: "tiki_sdk_flutter_engine")
                flutterEngine.run()
                GeneratedPluginRegistrant.register(with: flutterEngine);
                let channel = FlutterMethodChannel.init(name: TikiPlatformChannel.channelId, binaryMessenger: flutterEngine as! FlutterBinaryMessenger)
                channel.setMethodCallHandler(self.tikiPlatformChannel.handle)
                continuation.resume(returning: channel)
            }
        }
        let rspBuild: RspBuild = try await withCheckedThrowingContinuation{ continuation in
            let buildRequest = ReqBuild(apiId: apiId, origin: origin, address: address)
            do{
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.BUILD,
                    request: buildRequest,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
            
        }
        self.address = rspBuild.address
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
        let rspOwnership: RspOwnership = try await withCheckedThrowingContinuation{ continuation in
            do{
                let assignReq = ReqOwnershipAssign(
                    source: source, type: type, contains: contains, about: about, origin: origin)
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.ASSIGN_OWNERSHIP,
                    request: assignReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspOwnership.ownership!.transactionId
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
    ) async throws -> TikiSdkOwnership? {
        let rspOwnership : RspOwnership = try await withCheckedThrowingContinuation{ continuation in
            do{
                let getReq = ReqOwnershipGet(
                    source: source, origin: origin)
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.GET_OWNERSHIP,
                    request: getReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspOwnership.ownership
    }
    
    /// Modify consent for an ownership identified by *ownershipId*.
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
        let rspConsent : RspConsentGet = try await withCheckedThrowingContinuation{ continuation in
            do{   let getReq = ReqConsentModify(ownershipId : ownershipId,
                                                destination : destination,
                                                about: about,
                                                reward: reward,
                                                expiry:  expiry)
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.MODIFY_CONSENT,
                    request: getReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        return rspConsent.consent!
    }
    
    /// Gets latest consent given for a *source* and *origin*.
    ///
    /// It does not validate if the consent is expired or if it can be applied to
    /// a specific destination. For that, *applyConsent* should be used instead.
    /// If no *origin* is specified, it uses the default origin.
    ///
    /// - Parameters
    ///     - source: The identification of the data *source*.
    ///     - origin: Optional override for default origin.
    ///
    /// - Returns: Latest *TikiSdkConsent* for *source* and *origin*.
    /// - Throws: *TikiSdkError*
    public func getConsent(
        source: String,
        origin: String? = nil
    ) async throws -> TikiSdkConsent? {
        let rspConsent: RspConsentGet = try await withCheckedThrowingContinuation{ continuation in
            do{
                let getReq = ReqConsentGet(
                    source: source, origin: origin)
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.GET_CONSENT,
                    request: getReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
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
    ///     - origin: Optional override for default origin.
    public func applyConsent(
        source: String,
        destination: TikiSdkDestination,
        request:  (() -> Void),
        onBlocked:  ((String) -> Void)? = nil,
        origin: String? = nil
    ) async throws -> Void {
        let rspConsentApply: RspConsentApply = try await withCheckedThrowingContinuation{ continuation in
            let getReq = ReqConsentApply(
                source: source, destination: destination, origin: origin)
            do{
                try self.tikiPlatformChannel.invokeMethod(
                    method: MethodEnum.APPLY_CONSENT,
                    request: getReq,
                    continuation: continuation
                )
            }catch{
                continuation.resume(throwing: error)
            }
        }
        if(rspConsentApply.success){
            request();
        }else{
            onBlocked?(rspConsentApply.reason ?? "no consent")
        }
    }
}
