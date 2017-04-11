import Foundation
import UIKit

class TicketsLayout : UIView {
    let noTickets: UIView
    let buyTickets: UIButton
    
    required init() {
        let frame = Unit.screen
        let m2 = Unit.m2
        
        let width = frame.width - m2 * 2
        var font = Font.title
        
        let noTicketsTitle = UILabel(frame: CGRect(x: m2, y: m2, width: width, height: font.lineHeight))
        noTicketsTitle.text = "10 Ride Tickets"
        noTicketsTitle.font = font
        
        let noTicketsDescription = UILabel(frame: CGRect(x: m2, y: noTicketsTitle.frame.maxY + m2, width: width, height: 10))
        noTicketsDescription.text = "Ride tickets can be used on any Bloomington bus. Transfers are free and are valid for the next bus to your destination at locations where routes intersect."
        noTicketsDescription.numberOfLines = 0
        noTicketsDescription.resizeHeight()
        
        let noTicketsPrice = UILabel(frame: CGRect(x: m2, y: noTicketsDescription.frame.maxY + m2, width: width, height: font.lineHeight))
        noTicketsPrice.text = "$10"
        noTicketsPrice.textAlignment = .right
        noTicketsPrice.font = font
        
        noTickets = UIView(frame: CGRect(x: 0, y: m2, width: frame.width, height: noTicketsPrice.frame.maxY + m2))
        noTickets.backgroundColor = UIColor.white
        noTickets.addBorder(width: Unit.one, color: Palette.border, visible: BorderVisible(top: true, bottom: true))
        
        noTickets.addSubview(noTicketsTitle)
        noTickets.addSubview(noTicketsDescription)
        noTickets.addSubview(noTicketsPrice)
        
        font = Font.button
        buyTickets = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: font.lineHeight + m2 * 2))
        buyTickets.backgroundColor = UIColor.white
        buyTickets.setTitle("Buy", for: .normal)
        buyTickets.setTitleColor(buyTickets.tintColor, for: .normal)
        buyTickets.titleLabel?.font = font
        buyTickets.addBorder(width: Unit.one, color: Palette.border, visible: BorderVisible(top: true, bottom: true))
        
        super.init(frame: frame)
        backgroundColor = UIColor.groupTableViewBackground
        
        addSubview(noTickets)
        addSubview(buyTickets)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInsets(top: CGFloat?, bottom: CGFloat?) {
        let m2 = Unit.m2
        noTickets.frame.origin.y = (top ?? 0) + m2
        buyTickets.frame.origin.y = frame.height - buyTickets.frame.height - (bottom ?? 0) - m2
    }
    
}
