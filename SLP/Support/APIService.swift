
import Foundation
import Alamofire

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case tokenExpired
}

class APIService {
    
    static let commonHeader = ["idtoken": UserDefaults.standard.string(forKey: "idToken")!, "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders

    static func auth(completion: @escaping (Int?, APIError?) -> Void){
        
        let param: Parameters = [
            "phoneNumber" : UserDefaults.standard.string(forKey: "phoneNumber")!,
            "FCMtoken" : UserDefaults.standard.string(forKey: "fcmToken")!,
            "nick": UserDefaults.standard.string(forKey: "nickname")!,
            "birth": UserDefaults.standard.string(forKey: "birth")!,
            "email": UserDefaults.standard.string(forKey: "email")!,
            "gender" : UserDefaults.standard.integer(forKey: "gender")
        ]
        print(param)
        
        AF.request(EndPoint.user.url,
                   method: .post,
                   parameters: param,
                   headers: commonHeader)
            .responseString { response in
                
                completion(response.response?.statusCode, nil)
            }
    }
}
