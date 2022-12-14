import Foundation

public struct TikiSdkError : Error {

    var message: String?

    init(message: String?){
        self.message = message
    }
}
