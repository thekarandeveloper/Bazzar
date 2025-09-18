//
//  NotificationView.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//


import SwiftUI

struct NotificationView: View {
    
    
    
    var body: some View {
        ZStack {

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    HStack(alignment: .center, spacing: 20) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue.opacity(0.2))
                            .overlay(
                                Image(systemName: "bell")
                                    .font(.system(size: 18))
                                    .foregroundColor(.blue)
                            )
                            .frame(width: 50, height: 50)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Notification Title")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("Notification Description")
                                .font(.caption)
                                .foregroundColor(.gray)
                            HStack {
                                Spacer()
                                Text("Date")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding()
            }
        }
    }
}
#Preview{
    NotificationView()
}
