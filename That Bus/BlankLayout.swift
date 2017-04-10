import Foundation
import UIKit

class BlankLayout : UIView {
    
    required init() {
        super.init(frame: Unit.screen)
        backgroundColor = UIColor.magenta
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
