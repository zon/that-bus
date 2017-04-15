import Foundation
import UIKit

class TicketsController : UIViewController {
    let layout = TicketsLayout()
    
    private var group: PassGroup?
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        title = "Tickets"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
        
        layout.quantity.button.addTarget(self, action: #selector(buyTouch), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layout.setInsets(top: navigationController?.navigationBar.frame.maxY, bottom: tabBarController?.tabBar.frame.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progress(Product.get().then { products -> Void in
            if let product = products.first {
                let group = PassGroup(product: product, passes: [])
                self.group = group
                self.layout.update(group: group)
            } else {
                self.group = nil
                AlertController.show(message: "No passes found.")
            }
        })
    }
    
    func buyTouch() {
        if let group = group {
            progress(Session.getUser().then { user -> Void in
                let controller = CheckoutController(user: user, product: group.product)
                self.navigationController?.pushViewController(controller, animated: true)
            })
        }
    }
    
}
