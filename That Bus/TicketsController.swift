import Foundation
import UIKit

class TicketsController : UIViewController {
    let layout = TicketsLayout()
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        title = "Tickets"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
        
        layout.buyTickets.addTarget(self, action: #selector(buyTouch), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layout.setInsets(top: navigationController?.navigationBar.frame.maxY, bottom: tabBarController?.tabBar.frame.height)
    }
    
    func buyTouch() {
        navigationController?.pushViewController(RegisterController(), animated: true)
    }
    
}
