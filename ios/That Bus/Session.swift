import Foundation
import PromiseKit
import Alamofire

class Session {
    
    static func getUser() -> Promise<User> {
        return Alamofire.request(API.url("/session")).responseDoc()
    }
    
}
