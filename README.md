# Weather App Using Web API and MV Pattern in Swift

<img width="467" alt="Screenshot 2025-01-28 at 6 32 13 PM" src="https://github.com/user-attachments/assets/eb3885da-4728-4e51-9220-430d9f764ad2" />

## Overview

The Weather App is a SwiftUI application that allows users to fetch and display weather information based on city names. It utilizes the OpenWeatherMap API to retrieve weather data and follows the Model-View (MV) design pattern for a clean and maintainable code structure.

## Features

- **Search for Weather**: Users can enter a city name to retrieve current weather information.
- **Display Weather Data**: The app displays temperature, humidity, and other weather details.
- **Responsive Design**: The app is designed to work on various iOS devices with a user-friendly interface.

## Technologies Used

- **Swift**: The programming language used for developing the app.
- **SwiftUI**: A modern UI framework for building user interfaces across all Apple platforms.
- **Combine**: For handling asynchronous events and data streams.
- **OpenWeatherMap API**: A web service that provides weather data.

## Getting Started

### Prerequisites

- Xcode 12 or later
- An active internet connection
- An API key from OpenWeatherMap (sign up at [OpenWeatherMap](https://openweathermap.org/) to get your API key)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/weather-app.git
   cd weather-app
   ```

2. **Open the project in Xcode**:
   - Open `Weather App Using Web API and MV Pattern in Swift.xcodeproj` in Xcode.

3. **Add your API key**:
   - Open `Utlilties/constants.swift` and replace `"our api key"` with your actual OpenWeatherMap API key.

4. **Run the app**:
   - Select a simulator or a physical device and click the Run button in Xcode.

## Usage

1. Launch the app on your device or simulator.
2. Enter the name of a city in the search bar.
3. Press the magnifying glass button to fetch the weather data.
4. The app will display the current temperature and other weather details for the specified city.

## Code Structure

- **Models**: Contains data models such as `Weather`, `Weatherresponse`, and `Location` that represent the data structure returned by the OpenWeatherMap API.
- **Clients**: Contains network clients like `GeocodingClient` and `WeatherClient` that handle API requests and responses.
- **Views**: Contains SwiftUI views such as `ContentView` and `WeatherInfoItem` that define the user interface.
- **Utilities**: Contains constants and helper functions used throughout the app.

## API Endpoints

### Geocoding API

- **Endpoint**: `/geo/1.0/direct?q={city name}&appid={API key}`
- **Description**: Fetches coordinates for a given city name.

### Weather API

- **Endpoint**: `/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}`
- **Description**: Fetches weather data based on latitude and longitude.

## Contributing

Contributions are welcome! If you have suggestions for improvements or new features, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [OpenWeatherMap](https://openweathermap.org/) for providing the weather data API.
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) for the modern UI framework.
