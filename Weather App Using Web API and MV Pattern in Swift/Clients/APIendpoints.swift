//
//  APIendpoints.swift
//  Weather App Using Web API and MV Pattern in Swift
//
//  Created by Sameer,s Macbook on 1/28/25.
//


// to made the base url

import Foundation

enum APIendpoints {
    
    static let baseURL = "https://api.openweathermap.org"
    
    case coordinatesbyloactionname(String)
    case weatherbyLatonLong(Double,Double)
    
    private var path: String {
        switch self {
        case .coordinatesbyloactionname(let city):
            return "/geo/1.0/direct?q=\(city)&appid=\(Constants.Keys.WeatherAPIKey)"
        case .weatherbyLatonLong(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.Keys.WeatherAPIKey)"
        }
    }

    var urlString: String {
        return APIendpoints.baseURL + path
    }
    
}
