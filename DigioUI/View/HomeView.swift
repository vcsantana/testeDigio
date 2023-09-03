//
//  HomeView.swift
//  DigioUI
//
//  Created by Vandecarlos Santana on 02/09/23.
//
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    
    struct BannerView: View {
        let imageURLs: [URL]

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(imageURLs, id: \.self) { imageURL in
                        RemoteImage(url: imageURL)
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .cornerRadius(8)
                        
                    }
                }
            }
        }
    }
    
    struct RemoteImage: View {
        let url: URL
        @State private var image: UIImage? = nil
        
        var body: some View {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray // Pode exibir uma cor de fundo enquanto a imagem está sendo carregada
                    .onAppear {
                        loadImage()
                    }
            }
        }
        private func loadImage() {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    struct RemoteImageCard: View {
        let url: URL
        @State private var image: UIImage? = nil
        
        var body: some View {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray // Pode exibir uma cor de fundo enquanto a imagem está sendo carregada
                    .onAppear {
                        loadImage()
                    }
            }
        }
        
        private func loadImage() {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    struct CardViewImage: View {
        let cards : [ProductItem]
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(cards.indices, id: \.self) { index in
                        let card = cards[index]
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .frame(width: 100, height: 100)
                            .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 4)
                            .padding()
                            .overlay(
                                RemoteImageCard(url: card.imageURL)
                                    .frame(width: 60, height: 60)
                            )
                    }
                }
                
            }
        }
    }
        
    var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                if viewModel.isLoading {
                    ProgressView("Carregando...")
                } else if let error = viewModel.error {
                    Text("Erro: \(error.localizedDescription)")
                } else {
                    HStack {
                        Image("user")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(viewModel.name)
                            .bold()
                            
                    }
                    
                    BannerView(imageURLs: viewModel.banners.map(\.bannerURL))
                
                    
                    HStack(spacing:5) {
                      Text("digio")
                            .bold()
                            .foregroundColor(Color(red: 0.0, green: 30.0 / 255.0, blue: 90.0 / 255.0))
                            
                      Text("Cash")
                            .bold()
                            .foregroundColor(Color.gray)
                            
                    }
                    if let cashUrl = viewModel.cashUrl {
                        RemoteImage(url: cashUrl)
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .cornerRadius(8)
                    }
                    
                    Text("Produtos")
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 30.0 / 255.0, blue: 90.0 / 255.0))
                    
                    CardViewImage(cards: viewModel.cards)

                }
            }
            .padding(10)
            .onAppear {
                viewModel.loadData()
            }
        }
    
    
}







