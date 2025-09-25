//
//  RazorpayManager.swift
//  Bazzar
//
//  Created by Karan Kumar on 19/09/25.
//

import SwiftUI
import Razorpay

enum PaymentStatus {
    case idle
    case success(String)   // payment_id
    case failure(String)   // error message
}

class RazorpayManager: NSObject, ObservableObject, RazorpayPaymentCompletionProtocol {
    private var razorpay: RazorpayCheckout?
    
    @Published var paymentStatus: PaymentStatus = .idle
    
    override init() {
        super.init()
        // Do not initialize with open key until needed
    }
    
    func startPayment(amount: Double, productName: String) {
        // Ensure UI updates happen on main thread
        DispatchQueue.main.async {
            // Create razorpay instance here with delegate
            self.razorpay = RazorpayCheckout.initWithKey("rzp_test_RJBvI7h8RqfLzJ", andDelegate: self)
            
            // Make sure we have a valid root view controller
            guard let rootVC = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .first?.windows.first?.rootViewController else { return }
            let options: [String: Any] = [
                "amount": Int(amount * 100),
                "currency": "INR",
                "description": "Purchase \(productName)",
                "image": "https://yourdomain.com/logo.png",
                "name": "Bazzar",
                "prefill": [
                    "contact": "9876543210",
                    "email": "customer@example.com"
                ],
                "theme": [
                    "color": "#FF6600"
                ]
            ]
            
            if let presented = rootVC.presentedViewController {
                // Dismiss current, then open Razorpay
                presented.dismiss(animated: false) {
                    self.razorpay?.open(options, displayController: rootVC)
                }
            } else {
                self.razorpay?.open(options, displayController: rootVC)
            }
            
          
            // Open Razorpay checkout using root VC
            self.razorpay?.open(options, displayController: rootVC)
        }
    }
    
    // MARK: - RazorpayPaymentCompletionProtocol
    func onPaymentError(_ code: Int32, description str: String) {
        print("❌ Payment failed: \(str)")
        DispatchQueue.main.async {
            self.paymentStatus = .failure(str)
        }
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("✅ Payment success: \(payment_id)")
        DispatchQueue.main.async {
            self.paymentStatus = .success(payment_id)
        }
    }
}
