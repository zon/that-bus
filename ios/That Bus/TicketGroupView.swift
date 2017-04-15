import Foundation
import UIKit

class TicketGroupView : UIView {
    let label: UILabel
    let action: UILabel
    let button: UIButton
    
    required init() {
        let m2 = Unit.m2
        
        var width = CGFloat(100)
        action = UILabel(frame: CGRect(x: Unit.screen.width - width - m2, y: m2, width: width, height: Font.button.lineHeight + m2))
        action.textColor = action.tintColor
        action.textAlignment = .center
        action.font = Font.button
        action.addBorder(width: Unit.one, color: action.tintColor, visible: BorderVisible.yes, radius: 4)
        
        let height = action.frame.size.height + m2 * 2
        label = UILabel(frame: CGRect(x: m2, y: 0, width: action.frame.minX - m2 * 2, height: height))
        label.font = Font.label
        
        width = Unit.screen.width
        button = UIButton()
        button.frame.size = CGSize(width: width, height: height)
        
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        backgroundColor = Palette.white
        addBorder(width: Unit.one, color: Palette.border, visible: BorderVisible(top: true, bottom: true))
        
        addSubview(label)
        addSubview(action)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(group: TicketGroup) {
        label.text = group.name
        
        if group.hasActive {
            action.text = "1 Active"
            
        } else if group.purchased {
            action.text = "Activate"
        
        } else {
            action.text = "Buy \(Format.dollars(group.product.price))"
        }
    }
    
}
