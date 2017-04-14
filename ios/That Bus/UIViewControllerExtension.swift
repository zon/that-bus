import Foundation
import UIKit
import PromiseKit

extension UIViewController {
    
    func progress<T>(_ promise: Promise<T>) {
        ProgressController.show()
        promise
            .catch { error in AlertController.show(error: error) }
            .always { ProgressController.hide() }
    }
    
}
