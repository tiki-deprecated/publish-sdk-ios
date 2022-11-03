import tiki_sdk_flutter_plugin

public class TikiSdk {
    
    let plugin: TikiSdkFlutterPlugin
    
    public init(origin: String, apiKey: String = "") {
        let channel: FlutterMethodChannel = TikiSdkFlutterChannel(apiKey: apiKey, origin: origin)
        plugin = TikiSdkFlutterPlugin(methodChannel: channel)
    }
}
