import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class Product : DocProtocol {
    let id: String
    let singular: String
    let plural: String
    let price: Int
    let quantity: Int
    
    var name: String {
        if quantity == 1 {
            return "\(quantity) \(singular)"
        } else {
            return "\(quantity) \(plural)"
        }
    }
    
    required init?(json: JSON) {
        if
            let id = json["_id"].string,
            let singular = json["singular"].string,
            let plural = json["plural"].string,
            let price = json["price"].int,
            let quantity = json["quantity"].int
        {
            self.id = id
            self.singular = singular
            self.plural = plural
            self.price = price
            self.quantity = quantity
        } else {
            return nil
        }
    }
    
    static func get() -> Promise<[Product]> {
        return Alamofire
            .request(API.url("/products"))
            .promiseJSON()
            .then { $0.arrayValue.flatMap { Product(json: $0) } }
    }
    
}
