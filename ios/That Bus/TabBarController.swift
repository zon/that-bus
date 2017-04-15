import Foundation
import UIKit

class TabBarController : UITabBarController {
    let tickets: TicketsController
    let ticketsNavigation: UINavigationController
    let camera: CameraController
    let cameraNavigation: UINavigationController
    let profile: ProfileController
    let profileNavigation: UINavigationController
    
    required init() {
        tickets = TicketsController()
        ticketsNavigation = UINavigationController(rootViewController: tickets)
        
        camera = CameraController()
        cameraNavigation = UINavigationController(rootViewController: camera)
        
        profile = ProfileController()
        profileNavigation = UINavigationController(rootViewController: profile)
        
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [ticketsNavigation, cameraNavigation, profileNavigation]
        
        ticketsNavigation.tabBarItem.title = "Tickets"
        cameraNavigation.tabBarItem.title = "Camera"
        profileNavigation.tabBarItem.title = "Profile"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
