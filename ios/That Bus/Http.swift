import Foundation
import Alamofire
import SwiftyJSON

class Http {
    
    static let contentType = "application/json"
    
    static func request(_ url: String, method: HTTPMethod, json: JSON) -> Alamofire.DataRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        request.addValue(contentType, forHTTPHeaderField: "Accepts")
        request.addValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpBody = try! json.rawData()
        return Alamofire.request(request)
    }
    
}
