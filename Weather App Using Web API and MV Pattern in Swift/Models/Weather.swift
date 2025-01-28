//
//  Weather.swift
//  Weather App Using Web API and MV Pattern in Swift
//
//  Created by Sameer,s Macbook on 1/28/25.
//

//https://api.openweathermap.org/data/2.5/weather?lat=29.7589382&lon=-95.3676974&appid=
// we only want the main of that object that is send by the sever


import Foundation

struct  Weatherresponse: Decodable {
    let main: Weather
}

struct Weather : Decodable {
    let temp: Double
}
