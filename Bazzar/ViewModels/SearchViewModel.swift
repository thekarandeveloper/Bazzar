//
//  SearchViewModel.swift
//  Bazzar
//
//  Created by Karan Kumar on 18/09/25.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    // Example: Filtered data
    @Published var results: [String] = []
    
    private var allItems = ["Shirt", "Shoes", "Jeans", "Watch", "Bag"]
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Jab bhi searchText change hoga, filter run karo
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // typing delay
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterItems(with: text)
            }
            .store(in: &cancellables)
    }
    
    private func filterItems(with query: String) {
        if query.isEmpty {
            results = allItems
        } else {
            results = allItems.filter { $0.localizedCaseInsensitiveContains(query) }
        }
    }
}
