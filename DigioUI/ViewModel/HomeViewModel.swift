//
//  HomeViewModel.swift
//  DigioUI
//
//  Created by Vandecarlos Santana on 02/09/23.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var banners: [SpotlightItem] = []
    @Published var name: String = "Olá! Maria "
    @Published var cashUrl: URL? = nil
    @Published var cards: [ProductItem] = []
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    func loadData() {
        isLoading = true
    }
    private var apiClient = ApiClient()
        
        init() {
            apiClient.$response
                .sink { [weak self] response in
                    DispatchQueue.main.async {
                        self?.handleApiResponse(response)
                    }
                }
                .store(in: &cancellables)
        }
        
        private var cancellables: Set<AnyCancellable> = []
        
        func handleApiResponse(_ response: Response?) {
            isLoading = false
            guard let response = response else {
                return
            }
            
            banners = response.spotlight
            cards = response.products
            cashUrl = response.cash.bannerURL
            isLoading = false
        }
    
}
    


