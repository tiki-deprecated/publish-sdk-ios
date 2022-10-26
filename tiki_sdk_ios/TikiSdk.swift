import Flutter
import tiki_sdk_flutter_plugin

class TikiSdk{
    
    let plugin: TikiSdkFlutterPlugin
    
    public init(apiKey: String, origin: String){
        let channel = TikiSdkFlutterChannel(apiKey: apiKey, origin: origin)
        plugin = channel.plugin!
    }
    
    public func assignOwnership(
        source: String,
        type: String,
        contains: Array<String>,
        origin: String? = nil
    ) async throws -> String?  {
        try await plugin.assignOwnership(source: source, type: type, contains: contains, origin: origin)
    }

    public func modifyConsent(
        source: String,
        destination: TikiSdkFlutterDestination,
        about: String?,
        reward: String?
    ) async throws -> String?  {
        try await plugin.modifyConsent(source: source, destination: destination, about: about, reward: reward)
    }

    public func getConsent(
        source: String,
        origin: String? = nil
    ) async throws -> String?  {
        try await plugin.getConsent(source: source, origin: origin)
    }

    public func applyConsent(
        source: String,
        destination: TikiSdkFlutterDestination,
        request: (String?) -> Unit,
        onBlock: (String) -> Unit
    )  async throws -> Unit  {
        try await plugin.applyConsent(source: source, destination: destination, request: request, onBlock: onBlock)
    }

}
