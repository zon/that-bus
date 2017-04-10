import Foundation
import UIKit

class TabBarController : UITabBarController {
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            TicketsController(),
            ProfileController()
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
