import Foundation
import PromiseKit
import SwiftyJSON
import Alamofire
import Stripe

class StripeAdapter : NSObject, STPBackendAPIAdapter {
    static let shared = StripeAdapter()
    
    func retrieveCustomer(_ completion: @escaping STPCustomerCompletionBlock) {
        let url = API.url("/customer")
        if Settings.debug {
            print("GET", url)
        }
        Alamofire.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                let deserializer = STPCustomerDeserializer(data: data, urlResponse: nil, error: nil)
                if let error = deserializer.error {
                    completion(nil, error)
                } else if let customer = deserializer.customer {
                    completion(customer, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func attachSource(toCustomer source: STPSource, completion: @escaping STPErrorBlock) {
        let url = API.url("/customer/source")
        let params = ["source": source.stripeID]
        if Settings.debug {
            print("POST", url, params)
        }
        Alamofire
            .request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
    }
    
    func selectDefaultCustomerSource(_ source: STPSource, completion: @escaping STPErrorBlock) {
        let url = API.url("/customer/default_source")
        let params = ["source": source.stripeID]
        if Settings.debug {
            print("POST", url, params)
        }
        Alamofire
            .request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
    }
    
    func completeCharge(_ result: STPPaymentResult, amount: Int, completion: @escaping STPErrorBlock) {
        let json = JSON(["source": result.source.stripeID, "amount": amount])
        Http.request(API.url("/customer/charge"), method: .post, json: json)
            .responseOk()
            .then { ok in completion(nil) }
            .catch { err in completion(err) }
    }
    
}
