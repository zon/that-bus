import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class Pass : DocProtocol {
    let id: String
    let productId: String
    let expires: Date?
    
    required init?(json: JSON) {
        if
            let id = json["_id"].string,
            let productId = json["productId"].string
        {
            self.id = id
            self.productId = productId
            expires = json["expires"].date
        } else {
            return nil
        }
    }
    
    static func get() -> Promise<[Pass]> {
        return Alamofire
            .request(API.url("/passes"))
            .promiseJSON()
            .then { $0.arrayValue.flatMap { Pass(json: $0) } }
    }
    
}
