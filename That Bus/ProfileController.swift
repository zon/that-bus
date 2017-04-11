import Foundation
import UIKit

class ProfileController : UIViewController {
    let layout = BlankLayout()
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        title = "Profile"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
    }
    
    
    
}
