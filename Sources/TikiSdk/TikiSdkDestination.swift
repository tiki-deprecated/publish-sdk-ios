import Foundation

/// The destination to which the data is consented to be used.
public class TikiSdkDestination:Codable {
    
    /// An optional list of application specific uses cases
    /// applicable to the given destination. Prefix with NOT
    /// to invert. _i.e. NOT ads
    public let uses: Array<String>
    
    /// A list of paths, preferably URL without the scheme or
    /// reverse FQDN. Keep list short and use wildcard (*)
    /// matching. Prefix with NOT to invert.
    /// _i.e. NOT mytiki.com/*
    public let paths: Array<String>
    
    /// Builds a destination with [paths] and [uses]. Default to all uses.
    init(paths : Array<String> = [], uses : Array<String> = ["*"] ){
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
}
