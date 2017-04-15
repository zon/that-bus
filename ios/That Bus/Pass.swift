import Foundation
import SwiftyJSON

class Pass : DocProtocol {
    let id: String
    let productId: String
    
    required init?(json: JSON) {
        if
            let id = json["_id"].string,
            let productId = json["productId"].string
        {
            self.id = id
            self.productId = productId
        } else {
            return nil
        }
    }
    
}
