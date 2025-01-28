//
//  WeatherClient.swift
//  Weather App Using Web API and MV Pattern in Swift
//
//  Created by Sameer,s Macbook on 1/28/25.
//

import Foundation

struct WeatherClient {
    func fetchWeather(location: Location) async throws -> Weather {
        let endpoint = APIendpoints.weatherbyLatonLong(location.lat, location.lon)
        let (data, response) = try await URLSession.shared.data(from: URL(string: endpoint.urlString)!)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let weatherResponse = try JSONDecoder().decode(Weatherresponse.self, from: data)
        return weatherResponse.main
    }
}

