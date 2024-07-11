import SwiftUI
import Combine

class NetworkService: NSObject, ObservableObject {
    func downloadData<T: Decodable>(url: String, longitude: String, latitude: String, page: String) -> AnyPublisher<T, Error> {
        var components = URLComponents(string: url)
        let category = URLQueryItem(name: "category_group_code", value: "CE7")
        let longitude = URLQueryItem(name: "x", value: longitude)
        let latitude = URLQueryItem(name: "y", value: latitude)
        let radius = URLQueryItem(name: "radius", value: "500")
        let page = URLQueryItem(name: "page", value: page)
        components?.queryItems = [category, longitude, latitude, radius, page]
        
        guard let newURL = components?.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        guard let apiKey = Bundle.main.restAPIKey else {
            return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: newURL)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        return session
            .dataTaskPublisher(for: request)
            .tryMap { element -> Data in
                guard let response = element.response as? HTTPURLResponse, response.statusCode >= 200 else {
                    return Data()
                }
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
