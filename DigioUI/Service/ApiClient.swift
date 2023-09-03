//
//  ApiClient.swift
//  DigioUI
//
//  Created by Vandecarlos Santana on 02/09/23.
//

import Foundation

class ApiClient: ObservableObject {
    @Published var response: Response?
    @Published var error: Error?

    init() {
        fetchData()
    }

    func fetchData() {
        guard let url = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products") else {
            fatalError("Invalid URL")
        }
        
        print(url)

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.error = error
                    //print(error)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.error = NSError(domain: "No data received", code: 0, userInfo: nil)
                }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    //print(decodedResponse)
                    self.response = decodedResponse
                }
            } catch let decodingError {
                DispatchQueue.main.async {
                    self.error = decodingError
                    print(self.error)
                }
            }
        }.resume()
    }
}
