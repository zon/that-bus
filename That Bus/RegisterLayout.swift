import Foundation
import UIKit

class RegisterLayout : UIView {
    let content: UIView
    let email: TextField
    
    required init() {
        let frame = Unit.screen
        let m2 = Unit.m2
        
        let font = Font.medium
        email = TextField(frame: CGRect(x: 0, y: 0, width: frame.width, height: font.lineHeight + m2 * 2))
        email.backgroundColor = Palette.white
        email.addBorder(width: Unit.one, color: Palette.border, visible: BorderVisible(top: true, bottom: true))
        email.placeholder = "Email"
        email.padding = UIEdgeInsets(top: 0, left: m2, bottom: 0, right: m2)
        email.keyboardType = .emailAddress
        email.autocapitalizationType = .none
        email.returnKeyType = .next
        email.spellCheckingType = .no
        
        let details = UILabel(frame: CGRect(x: m2, y: email.frame.maxY + m2, width: frame.width - m2 * 2, height: 10))
        details.font = Font.small
        details.text = "Save your tickets online."
        details.resizeHeight()
        
        content = UIView(frame: CGRect(x: 0, y: m2, width: frame.width, height: details.frame.maxY + m2))
        content.addSubview(email)
        content.addSubview(details)
        
        super.init(frame: frame)
        backgroundColor = Palette.background
        
        addSubview(content)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInsets(top: CGFloat?, bottom: CGFloat?) {
        content.frame.origin.y = (top ?? 0) + Unit.m2
    }
    
}
