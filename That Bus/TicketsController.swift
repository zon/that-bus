import Foundation
import UIKit

class TicketsController : UIViewController {
    let layout = BlankLayout()
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = "Tickets"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
    }
    
}
