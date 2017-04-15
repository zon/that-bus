import Foundation
import UIKit
import AVFoundation

class TicketController : UIViewController {
    let product: Product
    let ticket: Ticket
    let item: AVPlayerItem
    let player: AVPlayer
    let layout = TicketLayout()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    required init(product: Product, ticket: Ticket) {
        self.product = product
        self.ticket = ticket
        
        let path = Bundle.main.path(forResource: "Inside Bus", ofType: "mp4")!
        let url = URL.init(fileURLWithPath: path)
        item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)
        
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: item, queue: nil) { _ in
            self.loop()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
        
        layout.playerLayer.player = player
        
        layout.back.addTarget(self, action: #selector(backTouch), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
        layout.update(product: product, ticket: ticket)
        
        player.volume = 0
        player.play()
    }
    
    func loop() {
        player.seek(to: kCMTimeZero)
        player.play()
    }
    
    func backTouch() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }
    
}
