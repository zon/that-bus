import Foundation
import UIKit

extension UIView {
    
    @discardableResult
    func addBorder(width: CGFloat, color: UIColor, visible: BorderVisible, radius: CGFloat = 0) -> CALayer {
        let border = CALayer()
        border.borderWidth = width
        border.borderColor = color.cgColor
        
        let top = visible.top ? 0 : -width
        let left = visible.left ? 0 : -width
        let bottom = visible.bottom ? 0 : -width
        let right = visible.right ? 0 : -width
        border.frame = CGRect(
            x: left,
            y: top,
            width: frame.width - left - right,
            height: frame.height - top - bottom
        )
        
        border.cornerRadius = radius
        layer.masksToBounds = true
        layer.addSublayer(border)
        return border
    }
    
    @discardableResult
    func addTopBorder(width: CGFloat, color: UIColor) -> CALayer {
        return addBorder(width: width, color: color, visible: BorderVisible(top: true))
    }
    
    @discardableResult
    func addBottomBorder(width: CGFloat, color: UIColor) -> CALayer {
        return addBorder(width: width, color: color, visible: BorderVisible(bottom: true))
    }
    
    @discardableResult
    func addLeftBorder(width: CGFloat, color: UIColor) -> CALayer {
        return addBorder(width: width, color: color, visible: BorderVisible(left: true))
    }
    
    @discardableResult
    func addRightBorder(width: CGFloat, color: UIColor) -> CALayer {
        return addBorder(width: width, color: color, visible: BorderVisible(right: true))
    }
    
    @discardableResult
    func addGridBorder(width: CGFloat, color: UIColor, length: Int, columns: Int, index: Int) -> CALayer {
        let rows = Int(ceil(Float(length) / Float(columns)))
        let column = index % columns
        let row = Int(floor((Float(index) / Float(length)) * Float(rows)))
        return addBorder(width: width, color: color, visible: BorderVisible(
            bottom: row + 1 < rows,
            right: column + 1 < columns
        ))
    }
    
    func resizeWidth() {
        let origin = frame.origin
        frame.size.width = CGFloat.greatestFiniteMagnitude
        sizeToFit()
        frame.origin = origin
    }
    
    func resizeHeight() {
        let origin = frame.origin
        frame.size.height = CGFloat.greatestFiniteMagnitude
        sizeToFit()
        frame.origin = origin
    }
    
    func hideKeyboardOnTap() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.dismissKeyboard)))
    }
    
    func dismissKeyboard() {
        endEditing(true)
    }
    
}

struct BorderVisible {
    let top: Bool
    let left: Bool
    let bottom: Bool
    let right: Bool
    
    static let yes = BorderVisible(top: true, left: true, bottom: true, right: true)
    
    init(top: Bool = false, left: Bool = false, bottom: Bool = false, right: Bool = false) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
    
}
