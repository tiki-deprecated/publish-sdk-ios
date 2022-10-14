    //
    //  TikiSdk.swift
    //  tiki_sdk_ios
    //
    //  Created by Ricardo on 12/10/22.
    //

    import Foundation
    import tiki_sdk_flutter_plugin


    class TikiSdk{
        
        init(apiKey: String){
            self.apiKey = apiKey
        }

        private var apiKey: String?
        private var flutterPlugin : SwiftTikiSdkFlutterPlugin = SwiftTikiSdkFlutterPlugin()

        func build() {
            flutterPlugin.channel.invokeMethod(
                "buildSdk",[
                    "apiKey" : apiKey
                ]
            )
        }

        func assignOwnership( source: String,  type: String,  contains: Array<String>?,  origin: String)
        {
            flutterPlugin.channel.invokeMethod(
                "assignOwnership", [
                    "source" : source,
                    "type" : type,
                    "contains" : contains,
                    "origin" : origin,
                ]
            )
        }

        func getConsent(source: String, origin: String?) {
            flutterPlugin.channel.invokeMethod(
                "getConsent", [
                    "source" : source,
                    "origin" : origin
                ]
            )
        }

        func modifyConsent(source: String, destination: TikiSdkDestination, about: String?, reward: String?
        ) {
            flutterPlugin.channel.invokeMethod(
                "modifyConsent", [
                    "source" : source,
                    "destination" : destination.toJson(),
                    "about" : about,
                    "reward" : reward,
                ])
        }

        func applyConsent(
            source: String,
            destination: TikiSdkDestination,
            requestId: String,
            request: () -> Unit,
            onBlock: (String) -> Unit
        ) {
            flutterPlugin.requestCallbacks[requestId] = request
            flutterPlugin.blockCallbacks[requestId] = onBlock
            SwiftTikiSdkFlutterPlugin.channel.invokeMethod(
                "applyConsent", [
                    "source" : source,
                    "destination" : destination,
                    "requestId" : requestId,
                ])
        }
    }
