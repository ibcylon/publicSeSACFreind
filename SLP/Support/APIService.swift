
import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case tokenExpired
}

class APIService {
    static func auth(nickname: String, password: String, completion: @escaping (User?, APIError?) -> Void){
        var request = URLRequest(url: EndPoint.register.url)
        
        request.httpMethod = Method.POST.rawValue
        request.httpBody = "identifier=\(nickname)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
}
