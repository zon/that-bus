import Foundation
import SwiftyJSON

class User : DocProtocol {
    let id: String
    let email: String?
    
    required init?(json: JSON) {
        if let id = json["_id"].string {
            self.id = id
        } else {
            return nil
        }
        email = json["email"].string
    }
    
}
