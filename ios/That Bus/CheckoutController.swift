import UIKit
import Stripe

class CheckoutController: UIViewController, STPPaymentContextDelegate {
    let user: User
    let quantity: TicketQuantity
    let context: STPPaymentContext
    let layout = CheckoutLayout()
    
    required init(user: User, quantity: TicketQuantity) {
        self.user = user
        self.quantity = quantity
        context = STPPaymentContext(apiAdapter: StripeAdapter.shared)
        
        super.init(nibName: nil, bundle: nil)
        title = "Checkout"
        
        context.delegate = self
        context.hostViewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
        
        layout.methodButton.addTarget(self, action: #selector(methodTouch), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layout.setInsets(top: navigationController?.navigationBar.frame.maxY, bottom: tabBarController?.tabBar.frame.height)
        layout.update(quantity: quantity, method: context.selectedPaymentMethod)
    }
    
    func paymentContextDidChange(_ context: STPPaymentContext) {
        if context.loading {
            ProgressController.show()
        } else {
            ProgressController.hide()
        }
        layout.update(quantity: quantity, method: context.selectedPaymentMethod)
    }
    
    func paymentContext(_ context: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        print("CREATE CHARGE")
    }
    
    func paymentContext(_ context: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        switch status {
        case .error:
            print("ERROR", error?.localizedDescription ?? "UNKNOWN")
        case .success:
            print("SUCCESS")
        case .userCancellation:
            return
        }
    }
    
    func paymentContext(_ context: STPPaymentContext, didFailToLoadWithError error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // Need to assign to _ because optional binding loses @discardableResult value
            // https://bugs.swift.org/browse/SR-1681
            _ = self.navigationController?.popViewController(animated: true)
        })
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.context.retryLoading()
        })
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func methodTouch() {
        context.pushPaymentMethodsViewController()
    }
    
}
