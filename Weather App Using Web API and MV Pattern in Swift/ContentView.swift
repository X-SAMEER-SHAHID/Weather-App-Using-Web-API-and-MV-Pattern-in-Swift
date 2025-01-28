//
//  ContentView.swift
//  Weather App Using Web API and MV Pattern in Swift
//
//  Created by Sameer,s Macbook on 1/28/25.
//

import SwiftUI

struct ContentView: View {
    
    // var body: some View {
        //     Button("get coordinates") {
        //         Task {
        //             let geocodingClient = GeocodingClient()
        //             let weatherclient = WeatherClient()
                    
                    
        //             let location = try! await geocodingClient.coordinateByCity("New York")
        //             let weather  =  try! await weatherclient.fetchWeather(location: location!)
                    
        //             print(weather)
        //         }
        //     }
        //     .padding()
        // }
    
    @State private var cityName: String = "" {
        didSet {
            // Clear temperature and error when search bar is emptied
            if cityName.isEmpty {
                temperature = nil
                errorMessage = nil
            }
        }
    }
    @State private var temperature: Double?
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.3)]),
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                Text("Weather App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                // Search bar at the top
                HStack {
                    TextField("Enter city name", text: $cityName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.words)
                        .cornerRadius(20)
                        .onChange(of: cityName) { oldValue, newValue in
                            if newValue.isEmpty {
                                temperature = nil
                                errorMessage = nil
                            }
                        }
                        .overlay(
                            Group {
                                if !cityName.isEmpty {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            cityName = ""
                                            temperature = nil
                                            errorMessage = nil
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                }
                            }
                        )
                    
                    Button(action: fetchWeather) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(Circle())
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                
                // Main content area
                if isLoading {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                    Spacer()
                } else if let temp = temperature {
                    GeometryReader { geometry in
                        VStack {
                            Spacer()
                            VStack(spacing: 20) {
                                Text(cityName)
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundColor(.white)
                                
                                Text("\(Int(temp - 273.15))°C")
                                    .font(.system(size: 96, weight: .bold))
                                    .foregroundColor(.white)
                                
                                // Additional weather info placeholder
                                HStack(spacing: 40) {
                                    WeatherInfoItem(icon: "thermometer", value: "Feels like", detail: "\(Int(temp - 273.15))°")
                                    WeatherInfoItem(icon: "humidity", value: "Humidity", detail: "64%")
                                }
                                .padding(.top, 20)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(30)
                            .padding(.horizontal)
                            Spacer()
                        }
                    }
                } else {
                    Spacer()
                    Text("Enter a city name to get weather information")
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
    }
    
    private func fetchWeather() {
        guard !cityName.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let geocodingClient = GeocodingClient()
                let weatherClient = WeatherClient()
                
                if let location = try await geocodingClient.coordinateByCity(cityName) {
                    let weather = try await weatherClient.fetchWeather(location: location)
                    await MainActor.run {
                        self.temperature = weather.temp
                        isLoading = false
                    }
                } else {
                    await MainActor.run {
                        errorMessage = "City not found"
                        isLoading = false
                    }
                }
            } catch {
                await MainActor.run {
                    errorMessage = "Error: \(error.localizedDescription)"
                    isLoading = false
                }
            }
        }
    }
}

// Helper view for weather info items
struct WeatherInfoItem: View {
    let icon: String
    let value: String
    let detail: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            Text(value)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            Text(detail)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
