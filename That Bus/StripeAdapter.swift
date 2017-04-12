import Foundation
import Stripe

class StripeAdapter : NSObject, STPBackendAPIAdapter {
    static let shared = StripeAdapter()
    
    func retrieveCustomer(_ completion: @escaping STPCustomerCompletionBlock) {
        print("RETRIEVE")
    }
    
    func attachSource(toCustomer source: STPSource, completion: @escaping STPErrorBlock) {
        print("ATTACH")
    }
    
    func selectDefaultCustomerSource(_ source: STPSource, completion: @escaping STPErrorBlock) {
        print("SELECT")
    }
    
}
