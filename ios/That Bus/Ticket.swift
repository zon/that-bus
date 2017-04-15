import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class Ticket : DocProtocol {
    let id: String
    let productId: String
    let expires: Date?
    
    var isActive: Bool {
        return expires != nil
    }
    
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
    
    static func get() -> Promise<[Ticket]> {
        return Alamofire
            .request(API.url("/tickets"))
            .promiseJSON()
            .then { $0.arrayValue.flatMap { Ticket(json: $0) } }
    }
    
}
