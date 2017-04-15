import UIKit
import Stripe

class CheckoutController: UIViewController, STPPaymentContextDelegate {
    let user: User
    let product: Product
    let adapter: StripeAdapter
    let context: STPPaymentContext
    let layout = CheckoutLayout()
    
    required init(user: User, product: Product) {
        self.user = user
        self.product = product
        adapter = StripeAdapter.shared
        context = STPPaymentContext(apiAdapter: adapter)
        context.paymentAmount = product.price
        
        super.init(nibName: nil, bundle: nil)
        title = "Checkout"
        hidesBottomBarWhenPushed = true
        
        context.delegate = self
        context.hostViewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = layout
        
        layout.methodButton.addTarget(self, action: #selector(methodTouch), for: .touchUpInside)
        layout.buy.addTarget(self, action: #selector(buyTouch), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        layout.setInsets(top: navigationController?.navigationBar.frame.maxY, bottom: tabBarController?.tabBar.frame.height)
        layout.update(product: product, method: context.selectedPaymentMethod)
    }
    
    func paymentContextDidChange(_ context: STPPaymentContext) {
        if context.loading {
            ProgressController.show()
        } else {
            ProgressController.hide()
        }
        layout.update(product: product, method: context.selectedPaymentMethod)
    }
    
    func paymentContext(_ context: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        adapter.completeCharge(paymentResult, product: product, completion: completion)
    }
    
    func paymentContext(_ context: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        switch status {
        case .error:
            if let error = error {
                AlertController.show(error: error)
            }
        case .success:
            navigationController?.popViewController(animated: true)
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
    
    func buyTouch() {
        context.requestPayment()
    }
    
}
