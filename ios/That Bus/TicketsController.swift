import Foundation
import UIKit
import PromiseKit

class TicketsController : UIViewController {
    let layout = TicketsLayout()
    
    private var group: TicketGroup?
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        title = "Tickets"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
        
        layout.quantity.button.addTarget(self, action: #selector(groupTouch), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layout.setInsets(top: navigationController?.navigationBar.frame.maxY, bottom: tabBarController?.tabBar.frame.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progress(when(fulfilled: Product.get(), Ticket.get()).then { products, tickets -> Void in
            if let product = products.first {
                let group = TicketGroup(product: product, tickets: tickets)
                self.group = group
                self.layout.update(group: group)
            } else {
                self.group = nil
                AlertController.show(message: "No tickets found.")
            }
        })
    }
    
    func groupTouch() {
        if let group = group, let navigation = navigationController {
            if let ticket = group.active {
                navigation.pushViewController(TicketController(product: group.product, ticket: ticket), animated: true)
                
            } else if group.hasTickets {
                progress(Ticket.activate().then { ticket -> Void in
                    navigation.pushViewController(TicketController(product: group.product, ticket: ticket), animated: true)
                })
                
            } else {
                progress(Session.getUser().then { user -> Void in
                    let controller = CheckoutController(user: user, product: group.product)
                    navigation.pushViewController(controller, animated: true)
                })
            }
        }
    }
    
}
