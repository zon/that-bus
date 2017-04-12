import Foundation
import UIKit

class RegisterController : UIViewController, UITextFieldDelegate {
    let layout = RegisterLayout()
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        title = "Register"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
        layout.email.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layout.setInsets(top: navigationController?.navigationBar.frame.maxY, bottom: tabBarController?.tabBar.frame.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let item = navigationController?.navigationBar.topItem {
            item.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTouch))
        }
        layout.email.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        nextTouch()
        return false
    }
    
    func backTouch() {
        dismiss(animated: true, completion: nil)
    }
    
    func nextTouch() {
        let quantity = TicketQuantity(name: "Ride Tickets", price: 10, count: 10)
        navigationController?.pushViewController(CheckoutController(quantity: quantity), animated: true)
    }
    
}
