import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        presentRoot(controller: TabBarController())
        
        return true
    }
    
    func presentRoot(controller: UIViewController) {
        let window = UIWindow(frame: Unit.screen)
        window.rootViewController = controller
        window.makeKeyAndVisible()
        self.window = window
    }


}

