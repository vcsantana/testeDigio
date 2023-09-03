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
    
    
    // Adicione métodos para carregar os dados da API ou qualquer outra fonte de dados.
    
    func loadData() {
        isLoading = true // Defina isLoading como true para indicar o carregamento
        //apiClient.fetchData()
    }
    private var apiClient = ApiClient()
        
        init() {
            // Inicialize sua classe aqui e observe as mudanças na resposta da API.
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
                // Lide com o erro ou carregamento aqui
                return
            }
            
            // Preencha seus campos com os dados da API
            banners = response.spotlight
            cards = response.products
            cashUrl = response.cash.bannerURL
            isLoading = false
        }
    
}
    


