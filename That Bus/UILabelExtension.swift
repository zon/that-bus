import Foundation
import UIKit

extension UILabel {
    
    func resizeHeight() {
        let origin = frame.origin
        frame.size.height = CGFloat.greatestFiniteMagnitude
        sizeToFit()
        frame.origin = origin
    }
    
}
