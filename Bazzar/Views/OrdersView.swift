//
//  OrdersView.swift
//  Bazzar
//
//  Created by Karan Kumar on 21/09/25.
//
import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var orderManager: OrderManager
        
        var body: some View {
            
            if orderManager.orders.isEmpty {
                VStack {
                    Spacer()
                    Text("No orders yet!")
                        .font(.headline)
                    Text("Place your first order to start shopping!")
                        .font(.caption)
                    Spacer()
                }
                .padding()
            } else{
                List(orderManager.orders) { order in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(order.product.name)
                                .font(.headline)
                            Text("$\(order.amount, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                            Text(order.date, style: .date)
                                .font(.caption2)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        switch order.status {
                        case .success(let id):
                            Text("✅ Paid")
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                        case .failure(let error):
                            Text("❌ Failed")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            
        }
}
