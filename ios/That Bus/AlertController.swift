import Foundation
import UIKit
import PromiseKit
import Alamofire

class AlertController : UIAlertController {
    var window: UIWindow?
    
    static var current: AlertController?
    
    static func show(message: String = "Something went wrong.", title: String? = "Error") {
        if current == nil {
            let alert = AlertController(title: title, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { (_) in }
            alert.addAction(ok)
            alert.show()
            current = alert
        }
    }
    
    static func show(error: Error, title: String? = "Error") {
        switch error {
            
        case DocResponseError.noJSON(let response):
            if Settings.debug {
                let status = response.response?.statusCode ?? 0
                let data = response.data.flatMap({ String(data: $0, encoding: String.Encoding.utf8) }) ?? ""
                print(status, data)
            }
            AlertController.show(title: title)
            
        case DocResponseError.serialization(_, let json):
            if Settings.debug {
                print(json)
            }
            AlertController.show(title: title)
            
        case let nserr as NSError:
            AlertController.show(message: nserr.localizedDescription, title: title)
            
        default:
            AlertController.show(title: title)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        window?.isHidden = true
        window = nil
        AlertController.current = nil
    }
    
    func show() {
        let controller = AlertBackgroundController()
        
        let win = UIWindow(frame: UIScreen.main.bounds)
        win.rootViewController = controller
        win.backgroundColor = UIColor.clear
        win.windowLevel = UIWindowLevelAlert + 10
        win.makeKeyAndVisible()
        self.window = win
        
        controller.present(self, animated: true, completion: nil)
    }
    
}

class AlertBackgroundController : UIViewController {
    
    override func loadView() {
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.clear
    }
    
}
