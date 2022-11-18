import Flutter
import Promises

public class TikiSdk{
    var promises: Dictionary<String, Promise<String?>> = [:]
    var methodChannel: TikiSdkFlutterChannel

    public init(origin: String, apiKey: String = "") {
        methodChannel = TikiSdkFlutterChannel(apiKey: apiKey, origin: origin)
        methodChannel.tikiSdk = self;
    }

    public func assignOwnership(
        source: String,
        type: String,
        contains: Array<String>,
        origin: String? = nil
    ) async throws -> String?  {

        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "assignOwnership", arguments: [
                "requestId" : requestId,
                "source" : source,
                "type" : type,
                "contains" : contains,
                "origin" : origin as Any
            ])
        let promise = Promise<String?>.pending()
        promises[requestId] = promise
        return try awaitPromise(promise)
    }

    public func modifyConsent(
        source: String,
        destination: TikiSdkDestination,
        about: String?,
        reward: String?
    ) async throws -> String?  {
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
        let promise = Promise<String?>.pending()
        promises[requestId] = promise
        return try awaitPromise(promise)
    }

    public func getConsent(
        source: String,
        origin: String? = nil
    ) async throws -> String?  {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "getConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "origin" : origin as Any
            ]
        )
        let promise = Promise<String?>.pending()
        promises[requestId] = promise
        return try awaitPromise(promise)
    }

    public func applyConsent(
        source: String,
        destination: TikiSdkDestination,
        request: (String?) -> Void,
        onBlock: (String) -> Void
    )  async throws -> Void  {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "applyConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "destination" : destination.toJson(),
            ]
        )
        do {
            let promise = Promise<String?>.pending()
            let response = try awaitPromise(promise)
            return request(response)
        } catch {
            return onBlock("no consent")
        }
    }
}
