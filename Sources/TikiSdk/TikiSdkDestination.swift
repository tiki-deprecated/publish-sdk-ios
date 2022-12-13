import Foundation

/// The destination to which the data is consented to be used.
public class TikiSdkDestination:Codable {
    
    /// An optional list of application specific uses cases
    /// applicable to the given destination. Prefix with NOT
    /// to invert. _i.e. NOT ads
    public var uses: Array<String> = []
    
    /// A list of paths, preferably URL without the scheme or
    /// reverse FQDN. Keep list short and use wildcard (*)
    /// matching. Prefix with NOT to invert.
    /// _i.e. NOT mytiki.com/*
    public var paths: Array<String> = []
    
    /// Builds a destination with [paths] and [uses]. Default to all uses.
    init(paths : Array<String>, uses : Array<String> = ["*"] ){
        self.uses = uses
        self.paths = paths
    }
    
    /// A TikiSdkDestination that includes all paths and uses.
    public static func all() -> TikiSdkDestination{
        return TikiSdkDestination(paths: ["*"], uses: ["*"])
    }
    
    /// A TikiSdkDestination without any paths or uses.
    ///
    /// Should be used for denying all consents given before.
    public static func none() -> TikiSdkDestination{
        return TikiSdkDestination(paths: [], uses: [])
    }
    
    /// Builds *TikiSdkDestination* from *jsonString*
    ///
    /// - Parameters
    ///     - jsonString: valid json representation of *TikiSdkDestination*
    ///
    /// - Returns: *TikiSdkDestination*
    public static func fromJson(jsonString : String) -> TikiSdkDestination{
        let decoder = JSONDecoder()
        do {
            let tikiSdkFlutterDestination = try decoder.decode(TikiSdkDestination.self, from:  Data(jsonString.utf8))
            return tikiSdkFlutterDestination
        } catch {
            objc_exception_rethrow()
        }
    }
    
    /// Converts this to a JSON String
    ///
    /// - Returns:valid json representation of *TikiSdkDestination*
    public func toJson() -> String{
        let encoder = JSONEncoder()
        do {
            return String(data: try encoder.encode(self), encoding: String.Encoding.utf8)!
        } catch {
            objc_exception_rethrow()
        }
    }
}
