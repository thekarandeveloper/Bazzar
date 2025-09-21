//
//  Address.swift
//  Bazzar
//
//  Created by Karan Kumar on 21/09/25.
//


import SwiftUI
import SwiftData

struct AddressEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    // Form state
    @State private var name = ""
    @State private var phone = ""
    @State private var street = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zip = ""
    @State private var country = ""
    
    var body: some View {
        Form {
            Section(header: Text("Contact Info")) {
                TextField("Full Name", text: $name)
                TextField("Phone Number", text: $phone)
                    .keyboardType(.phonePad)
            }
            
            Section(header: Text("Address")) {
                TextField("Street Address", text: $street)
                TextField("City", text: $city)
                TextField("State", text: $state)
                TextField("Zip Code", text: $zip)
                    .keyboardType(.numberPad)
                TextField("Country", text: $country)
            }
            
            Section {
                Button(action: saveAddress) {
                    Text("Save Address")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
        }
        .navigationTitle("Add Address")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Save Address
    private func saveAddress() {
        guard !name.isEmpty,
              !phone.isEmpty,
              !street.isEmpty,
              !city.isEmpty,
              !state.isEmpty,
              !zip.isEmpty,
              !country.isEmpty else {
            print("⚠️ Please fill all fields")
            return
        }
        
        let newAddress = Address(
            name: name,
            phone: phone,
            street: street,
            city: city,
            state: state,
            zip: zip,
            country: country
        )
        
        context.insert(newAddress)
        do {
            try context.save()
            dismiss() // sheet close on success
            print("✅ Address saved")
        } catch {
            print("❌ Error saving address: \(error.localizedDescription)")
        }
    }
}
