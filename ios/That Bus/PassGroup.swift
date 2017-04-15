import Foundation

struct PassGroup {
    let product: Product
    let passes: [Pass]
    
    var quantity: Int {
        if passes.count > 0 {
            return passes.count
        } else {
            return product.quantity
        }
    }
    
    var name: String {
        let quantity = self.quantity
        if quantity == 1 {
            return "\(quantity) \(product.singular)"
        } else {
            return "\(quantity) \(product.plural)"
        }
    }
    
    var purchased: Bool {
        return passes.count > 0
    }
    
}
