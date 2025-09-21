//
//  AddressListView.swift
//  Bazzar
//
//  Created by Karan Kumar on 21/09/25.
//


import SwiftUI
import SwiftData

struct AddressListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Address.createdAt, order: .reverse) private var savedAddresses: [Address]
    
    @State private var showAddSheet = false
    
    var body: some View {
        VStack {
            if savedAddresses.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "map.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray.opacity(0.6))
                    Text("No saved addresses")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                List {
                    ForEach(savedAddresses) { address in
                        AddressCardView(address: address)
                    }
                    .onDelete(perform: deleteAddress)
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("My Addresses")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { showAddSheet.toggle() }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.orange)
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            NavigationStack {
                AddressEntryView()
            }
        }
    }
    
    // Delete
    private func deleteAddress(at offsets: IndexSet) {
        for index in offsets {
            context.delete(savedAddresses[index])
        }
        do { try context.save() } catch {
            print("❌ Error deleting address: \(error)")
        }
    }
}

// MARK: - Card View
struct AddressCardView: View {
    var address: Address
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(address.name)
                .font(.headline)
            Text(address.street)
            Text("\(address.city), \(address.state) - \(address.zip)")
            Text(address.country)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("📞 \(address.phone)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
