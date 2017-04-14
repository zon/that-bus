import Foundation
import Alamofire
import SwiftyJSON

enum DocResponseError : Error {
    case noJSON(response: DataResponse<Data>)
    case serialization(response: DataResponse<Data>, json: JSON)
}
