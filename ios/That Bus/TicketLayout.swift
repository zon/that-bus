import Foundation
import UIKit
import AVFoundation

class TicketLayout : UIView {
    let playerLayer: AVPlayerLayer
    let back: UIButton
    
    required init() {
        let frame = Unit.screen
        
        playerLayer = AVPlayerLayer(player: nil)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.frame = frame
        
        let height = frame.height / 6
        let background = UIColor.black.withAlphaComponent(0.7)
        let header = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: height))
        header.backgroundColor = background
        
        let footer = UIView(frame: CGRect(x: 0, y: frame.height - height, width: frame.width, height: height))
        footer.backgroundColor = background
        
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
    
}
