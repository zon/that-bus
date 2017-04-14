import Foundation
import UIKit
import Stripe

class CheckoutLayout : UIView {
    let content: UIView
    let quantityLabel: UILabel
    let quantityPrice: UILabel
    let methodImage: UIImageView
    let methodLabel: UILabel
    let methodButton: UIButton
    let buy: UIButton
    let buyBorder: CALayer
    
    required init() {
        let frame = Unit.screen
        let m2 = Unit.m2
        
        var width = (frame.width - m2 * 3) / 2
        var font = Font.medium
        quantityLabel = UILabel(frame: CGRect(x: m2, y: m2, width: width, height: font.lineHeight))
        quantityLabel.font = font
        
        quantityPrice = UILabel(frame: CGRect(x: quantityLabel.frame.maxX + m2, y: m2, width: width, height: font.lineHeight))
        quantityPrice.font = font
        quantityPrice.textAlignment = .right
        
        methodImage = UIImageView(frame: CGRect(x: m2, y: quantityPrice.frame.maxY + m2 * 2, width: 32, height: 20))
        
        methodLabel = UILabel(frame: CGRect(
            x: methodImage.frame.maxX + m2,
            y: methodImage.frame.origin.y,
            width: frame.width - methodImage.frame.maxX - m2 * 2,
            height: methodImage.frame.height
        ))
        methodLabel.font = font
        methodLabel.textAlignment = .right
        
        methodButton = UIButton(frame: CGRect(
            x: 0,
            y: methodImage.frame.minY - m2,
            width: frame.width,
            height: methodImage.frame.height + m2  * 2
        ))
        methodButton.addBorder(width: Unit.one, color: Palette.border, visible: BorderVisible(top: true, bottom: true))
        
        width = 75
        font = Font.button
        buy = UIButton(frame: CGRect(
            x: frame.width - width - m2,
            y: methodButton.frame.maxY + m2,
            width: width,
            height: font.lineHeight + m2
        ))
        buy.setTitle("Buy", for: .normal)
        buy.setTitleColor(buy.tintColor, for: .normal)
        buy.setTitleColor(UIColor.lightGray, for: .disabled)
        buy.titleLabel?.font = font
        buyBorder = buy.addBorder(width: Unit.one, color: buy.tintColor, visible: BorderVisible.yes, radius: 4)
        
        let body = UIView(frame: CGRect(x: 0, y: m2, width: frame.width, height: buy.frame.maxY + m2))
        body.backgroundColor = Palette.white
        body.addBorder(width: Unit.one, color: Palette.border, visible: BorderVisible(top: true, bottom: true))
        
        body.addSubview(quantityLabel)
        body.addSubview(quantityPrice)
        body.addSubview(methodImage)
        body.addSubview(methodLabel)
        body.addSubview(methodButton)
        body.addSubview(buy)
        
        content = UIView(frame: frame)
        content.addSubview(body)
        
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
    
    func update(quantity: TicketQuantity, method: STPPaymentMethod?) {
        quantityLabel.text = "\(quantity.count) \(quantity.name)"
        quantityPrice.text = "$\(quantity.price)"
        
        if let method = method {
            methodImage.image = method.image
            methodLabel.text = method.label
            methodLabel.textColor = UIColor.black
            
        } else {
            methodImage.image = nil
            methodLabel.text = "No Payment Method"
            methodLabel.textColor = UIColor.gray
        }
        
        buy.isEnabled = method != nil
        if buy.isEnabled {
            buyBorder.borderColor = buy.tintColor.cgColor
        } else {
            buyBorder.borderColor = UIColor.lightGray.cgColor
        }
    }
    
}
