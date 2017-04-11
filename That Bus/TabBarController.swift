import Foundation
import UIKit

class TabBarController : UITabBarController {
    let tickets: TicketsController
    let ticketsNavigation: UINavigationController
    let profile: ProfileController
    let profileNavigation: UINavigationController
    
    required init() {
        tickets = TicketsController()
        ticketsNavigation = UINavigationController(rootViewController: tickets)
        
        profile = ProfileController()
        profileNavigation = UINavigationController(rootViewController: profile)
        
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [ticketsNavigation, profileNavigation]
        
        ticketsNavigation.tabBarItem.title = "Tickets"
        profileNavigation.tabBarItem.title = "Profile"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
