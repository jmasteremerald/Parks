//
//  ParksResponse.swift
//  Parks
//
//  Created by Jaali Patterson on 10/22/24.
//

import Foundation
struct ParksResponse: Codable {
    
    let data: [Park]
    
}
struct Park: Codable, Identifiable, Hashable, Equatable{
    let id: String
    let fullName: String
    let description: String
    let latitude: String
    let longitude: String
    let images: [ParkImage]
    let name: String
    
    func hash(into hasher: inout Hasher) { // <-- Add required hash function
        hasher.combine(id)
    }
}
struct ParkImage: Codable, Identifiable, Equatable { // <-- Add Equatable protocol
    let title: String
    let caption: String
    let url: String

    var id: String {
        url
    }
}
extension Park {
    static var mocked: Park {
        // Provide a fallback or dummy park in case of errors
        let fallbackPark = Park(id: "0", fullName: "Mock Park", description: "Description not available", latitude: "0", longitude: "0", images: [], name: "Mock Park")

        // Attempt to load the mocked park from the JSON file
        guard let jsonUrl = Bundle.main.url(forResource: "park_mock", withExtension: "json") else {
            print("Failed to find park_mock.json file.")
            return fallbackPark
        }

        do {
            let data = try Data(contentsOf: jsonUrl)
            let park = try JSONDecoder().decode(Park.self, from: data)
            return park
        } catch {
            print("Error decoding Park from JSON: \(error.localizedDescription)")
            return fallbackPark
        }
    }
}




