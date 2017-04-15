import Foundation
import UIKit

class TicketQuantityView : UIView {
    let label: UILabel
    let button: UIButton
    
    required init() {
        let m2 = Unit.m2
        
        let width = CGFloat(100)
        button = UIButton(frame: CGRect(x: Unit.screen.width - width - m2, y: m2, width: width, height: Font.button.lineHeight + m2))
        button.setTitleColor(button.tintColor, for: .normal)
        button.titleLabel?.font = Font.button
        button.addBorder(width: Unit.one, color: button.tintColor, visible: BorderVisible.yes, radius: 4)
        
        let height = button.frame.size.height + m2 * 2
        label = UILabel(frame: CGRect(x: m2, y: 0, width: button.frame.minX - m2 * 2, height: height))
        label.font = Font.label
        
        super.init(frame: CGRect(x: 0, y: 0, width: Unit.screen.width, height: height))
        backgroundColor = Palette.white
        addBorder(width: Unit.one, color: Palette.border, visible: BorderVisible(top: true, bottom: true))
        
        addSubview(label)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(group: PassGroup) {
        label.text = group.name
        
        let title = group.purchased ? "Activate" : "Buy \(Format.dollars(group.product.price))"
        button.setTitle(title, for: .normal)
    }
    
}
