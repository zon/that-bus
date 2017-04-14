import Foundation
import Alamofire
import Stripe

class StripeAdapter : NSObject, STPBackendAPIAdapter {
    static let shared = StripeAdapter()
    
    func retrieveCustomer(_ completion: @escaping STPCustomerCompletionBlock) {
        Alamofire.request(API.url("/customer")).responseData { response in
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
        let params = ["source": source.stripeID]
        Alamofire
            .request(API.url("/customer/source"), method: .post, parameters: params, encoding: JSONEncoding.default)
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
        let params = ["source": source.stripeID]
        Alamofire
            .request(API.url("/customer/default_source"), method: .post, parameters: params, encoding: JSONEncoding.default)
            .responseData { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
    }
    
}
