import Foundation

// Custom error type for network-related errors
enum NetworkError: Error {
    case invalidResponse
}

struct GeocodingClient {
    
    /// Fetches coordinates for a given city name
    /// - Parameter city: Name of the city to look up
    /// - Returns: Optional Location object containing coordinates if found
    /// - Throws: NetworkError if the response is invalid
    func coordinateByCity(_ city: String) async throws -> Location? {
        // Create the API endpoint URL for geocoding the city
        let endpoint = APIendpoints.coordinatesbyloactionname(city)
        
        // Make the network request and get data and response
        let (data, response) = try await URLSession.shared.data(from: URL(string: endpoint.urlString)!)
        
        // Verify we got a valid HTTP response with 200 status code
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        // Decode the JSON response into an array of Location objects
        let locations = try JSONDecoder().decode([Location].self, from: data)
        
        // Return the first location if any were found
        return locations.first
    }
}

