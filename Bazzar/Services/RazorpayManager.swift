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
    var razorpay: RazorpayCheckout?
    
   
    @Published var paymentStatus: PaymentStatus = .idle
    
    override init() {
        super.init()
        razorpay = RazorpayCheckout.initWithKey("rzp_test_RJBvI7h8RqfLzJ", andDelegate: self)
    }
    
    func startPayment(amount: Double, productName: String) {
        let options: [String:Any] = [
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
        razorpay?.open(options)
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
