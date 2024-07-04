import Foundation

extension Bundle {
    var authAPIKey: String? {
        return infoDictionary?["AUTH_API_KEY"] as? String
    }
    
    var restAPIKey: String? {
        return infoDictionary?["REST_API_KEY"] as? String
    }
}
