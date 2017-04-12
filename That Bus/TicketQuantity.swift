import Foundation

class TicketQuantity {
    let name: String
    let price: Int
    var count: Int
    var purchased: Bool
    
    required init(name: String, price: Int, count: Int, purchased: Bool = false) {
        self.name = name
        self.price = price
        self.count = count
        self.purchased = purchased
    }
    
}
