import Flutter

public typealias TikiSdkCompletion = (Bool, String?) -> Void
public class TikiSdk{
    var completions: Dictionary<String, TikiSdkCompletion> = [:]
    var methodChannel: TikiSdkFlutterChannel
    var address: String?

    public init(origin: String, apiKey: String = "") {
        methodChannel = TikiSdkFlutterChannel(apiKey: apiKey, origin: origin)
        methodChannel.tikiSdk = self;
    }

    public func assignOwnership(
        source: String,
        type: String,
        contains: Array<String>,
        completion: @escaping TikiSdkCompletion,
        origin: String? = nil
    ) {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "assignOwnership", arguments: [
                "requestId" : requestId,
                "source" : source,
                "type" : type,
                "contains" : contains,
                "origin" : origin as Any
            ])
        completions[requestId] = completion
    }

    public func modifyConsent(
        source: String,
        destination: TikiSdkDestination,
        completion: @escaping TikiSdkCompletion,
        about: String? = nil,
        reward: String? = nil
    ) {
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
        completions[requestId] = completion
    }

    public func getConsent(
        source: String,
        completion: @escaping TikiSdkCompletion,
        origin: String? = nil
    ) {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "getConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "origin" : origin as Any
            ]
        )
        completions[requestId] = completion
    }

    public func applyConsent(
        source: String,
        destination: TikiSdkDestination,
        request:  @escaping (String?) -> Void,
        onBlock:  @escaping (String?) -> Void
    ) {
        let requestId = UUID().uuidString
        methodChannel.invokeMethod(
            "applyConsent",  arguments: [
                "requestId" : requestId,
                "source" : source,
                "destination" : destination.toJson(),
            ]
        )
        completions[requestId] = { result, response in
            if(result){
                request(response)
            }else{
                onBlock(response)
            }
        }
        
    }
}
