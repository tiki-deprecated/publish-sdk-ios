import Foundation

public struct TikiSdkError : Error {

    var message: String?
    var stackTrace: String?

    init(message: String?, stackTrace: String?){
        self.message = message
        self.stackTrace = stackTrace
    }
}
