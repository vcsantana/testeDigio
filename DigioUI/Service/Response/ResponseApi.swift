//
//  ResponseApi.swift
//  DigioUI
//
//  Created by Vandecarlos Santana on 02/09/23.
//
import Foundation

struct Response: Codable {
    let spotlight: [SpotlightItem]
    let products: [ProductItem]
    let cash: CashItem
}

struct SpotlightItem: Codable {
   // var id = UUID()
    let name: String
    let bannerURL: URL
    let description: String
}

struct ProductItem: Codable {
    //var id = UUID()
    let name: String
    let imageURL: URL
    let description: String
}

struct CashItem: Codable {
    let title: String
    let bannerURL: URL
    let description: String
}
