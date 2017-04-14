import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

extension DataRequest {
    
    func promiseJSON<S: Sequence>(statusCode: S) -> Promise<JSON> where S.Iterator.Element == Int {
        log()
        return Promise { fulfill, reject in
            self.validate(statusCode: statusCode)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data: data)
                        fulfill(json)
                    case .failure(let error):
                        reject(error)
                    }
                }
        }
    }
    
    func promiseJSON() -> Promise<JSON> {
        return promiseJSON(statusCode: 200..<300)
    }
    
    func responseDoc<D: DocProtocol>() -> Promise<D> {
        log()
        return Promise { fulfill, reject in
            self.validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        let json = JSON(data: data)
                        if let doc = D(json: json) {
                            fulfill(doc)
                        } else {
                            reject(DocResponseError.serialization(response: response, json: json))
                        }
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
    func responseOk<S: Sequence>(statusCode: S) -> Promise<Bool> where S.Iterator.Element == Int {
        log()
        return Promise { fulfill, reject in
            self.validate(statusCode: statusCode)
                .responseData { response in
                    switch response.result {
                    case .success:
                        fulfill(true)
                    case .failure(let error):
                        reject(error)
                    }
            }
        }
    }
    
    func responseOk() -> Promise<Bool> {
        return responseOk(statusCode: 200..<300)
    }
    
    func log() {
        if Settings.debug {
            if let method = request?.httpMethod, let url = request?.url {
                if let data = request?.httpBody, let body = String(data: data, encoding: String.Encoding.utf8) {
                    print(method, url, body)
                } else {
                    print(method, url)
                }
                
            }
        }
    }
    
}
