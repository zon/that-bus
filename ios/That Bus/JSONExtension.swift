import Foundation
import SwiftyJSON
import CoreLocation

extension JSON {
    
    var date: Date? {
        get {
            if let str = string {
                return Format.jsonDate.date(from: str)
            } else {
                return nil
            }
        }
    }
    
}
