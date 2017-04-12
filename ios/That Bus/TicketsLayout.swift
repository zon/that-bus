import Foundation
import UIKit

class TicketsLayout : UIView {
    let content: UIView
    let quantity: TicketQuantityView
    let details: UILabel
    
    required init() {
        let frame = Unit.screen
        let m2 = Unit.m2
        
        quantity = TicketQuantityView()
        quantity.frame.origin.y = m2
        
        let width = frame.width - m2 * 2
        details = UILabel(frame: CGRect(x: m2, y: quantity.frame.maxY + m2, width: width, height: 0))
        details.font = Font.small
        details.textColor = UIColor.gray
        details.text = "Ride tickets can be used on any Bloomington bus. Transfers are free and are valid for the next bus to your destination at locations where routes intersect."
        details.numberOfLines = 0
        details.resizeHeight()
        
        content = UIView(frame: frame)
        content.addSubview(quantity)
        content.addSubview(details)
        
        super.init(frame: frame)
        backgroundColor = Palette.background
        
        addSubview(content)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInsets(top: CGFloat?, bottom: CGFloat?) {
        content.frame.origin.y = top ?? 0
    }
    
    func update(quantity: TicketQuantity) {
        self.quantity.update(quantity: quantity)
    }
    
}
