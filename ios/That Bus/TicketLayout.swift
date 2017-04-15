import Foundation
import UIKit
import AVFoundation

class TicketLayout : UIView {
    let title: UILabel
    let countdown: UILabel
    let playerLayer: AVPlayerLayer
    let back: UIButton
    
    required init() {
        let frame = Unit.screen
        
        playerLayer = AVPlayerLayer(player: nil)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.frame = frame
        
        let height = frame.height / 6
        let background = UIColor.black.withAlphaComponent(0.4)
        let header = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: height))
        header.backgroundColor = background
        
        title = UILabel()
        title.frame.size = header.frame.size
        title.textColor = UIColor.white
        title.textAlignment = .center
        title.font = Font.label.withSize(46)
        header.addSubview(title)
        
        let footer = UIView(frame: CGRect(x: 0, y: frame.height - height, width: frame.width, height: height))
        footer.backgroundColor = background
        
        countdown = UILabel()
        countdown.frame.size = footer.frame.size
        countdown.textColor = UIColor.white
        countdown.textAlignment = .center
        countdown.font = Font.label.withSize(32)
        footer.addSubview(countdown)
        
        back = UIButton()
        back.frame.size = frame.size
        
        super.init(frame: frame)
        backgroundColor = UIColor.black
        layer.addSublayer(playerLayer)
        
        addSubview(header)
        addSubview(footer)
        addSubview(back)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(product: Product, ticket: Ticket) {
        title.text = product.singular.uppercased()
        countdown.text = "10:00"
    }
    
}
