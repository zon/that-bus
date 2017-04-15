import Foundation
import UIKit

class CameraController : UIViewController {
    let layout = BlankLayout()
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        title = "Camera"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        layout.backgroundColor = UIColor.yellow
        view = layout
    }
    
}
