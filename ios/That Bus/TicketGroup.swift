import Foundation

struct TicketGroup {
    let product: Product
    let tickets: [Ticket]
    
    var quantity: Int {
        if tickets.count > 0 {
            return tickets.count
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
        return tickets.count > 0
    }
    
    var hasActive: Bool {
        for ticket in tickets {
            if ticket.isActive {
                return true
            }
        }
        return false
    }
    
}
