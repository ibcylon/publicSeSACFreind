import Foundation
import Alamofire
import FirebaseAuth

class UserAPIService {
    
    static let shared = UserAPIService()
    
    private init() {
        
    }
    
    static let commonHeader = ["idtoken": UserManager.idToken ?? "", "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
    
    static func register(request: RegisterRequest, completion: @escaping (Int?, Error?) -> Void) {

        AF.request(UserTarget.register(request))
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    static func login(completion: @escaping (UserResponse?, Int?, Error?) -> Void) {

        AF.request(UserTarget.login)
            .responseDecodable(of: UserResponse.self) { response in
                switch response.result {
                case .success:
                    completion(response.value, response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, nil, error)
                }
            }
    }

    static func withdraw(completion: @escaping (Int?, Error?) -> Void) {

        AF.request(UserTarget.withdraw)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    static func updateUser(request: UpdateMyPageRequest, completion: @escaping (Int?, Error?) -> Void) {

        AF.request(UserTarget.updateMypage(request))
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    static func updateFCMToken(request: UpdateFCMToken, completion: @escaping (Int?, Error?) -> Void) {

        AF.request(UserTarget.updateFCMtoken(request))
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
}
