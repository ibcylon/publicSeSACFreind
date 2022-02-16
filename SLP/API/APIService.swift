
import Foundation
import Alamofire
import FirebaseAuth

enum APIError: Error{
    case invalidResponse
    case noData
    case failed
    case invalidData
    case tokenExpired
}

enum SLPAPIError: Int {
    case success = 200
    case existedUser = 201
    case invalidNickname = 202
    case tokenError = 401
    case unRegisterError = 406
    case serverError = 500
    case clientError = 501
}

extension SLPAPIError {
    
}



class APIService {
    
    static let shared = APIService()
    
    private init(){
        
        //token refresh
        
    }
    
    static let commonHeader = ["idtoken": UserDefaults.standard.string(forKey: "idToken")!, "Content-Type": "application/x-www-form-urlencoded"] as HTTPHeaders
    
    //MARK: Auth
    static func login(completion: @escaping (Int?, APIError?) -> Void){
        
        AF.request(EndPoint.user.url,
                   method: .get,
                   headers: commonHeader)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    static func auth(completion: @escaping (Int?, APIError?) -> Void){
        
        let parameters: Parameters = [
            "phoneNumber" : UserDefaults.standard.string(forKey: "phoneNumber")!,
            "FCMtoken" : UserDefaults.standard.string(forKey: "fcmToken")!,
            "nick": UserDefaults.standard.string(forKey: "nickname")!,
            "birth": UserDefaults.standard.string(forKey: "birth")!,
            "email": UserDefaults.standard.string(forKey: "email")!,
            "gender" : UserDefaults.standard.integer(forKey: "gender")
        ]
        
        AF.request(EndPoint.user.url,
                   method: .post,
                   parameters: parameters,
                   headers: commonHeader)
            .responseString { response in
                
                switch response.result {
                case .success :
                    guard let statusCode = response.response?.statusCode else {
                        return
                    }
                    
                    
                    completion(statusCode, nil)
                    
                    
                case .failure(let error) :
                    print(#function, error)
                }
            }
    }
    
    static func refreshToken(){
        let currentUserInstance = Auth.auth().currentUser
        currentUserInstance?.getIDTokenForcingRefresh(true, completion: { idToken, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            UserDefaults.standard.set(idToken, forKey: "idToken")
            print(UserDefaults.standard.string(forKey: "idToken")!)
        })
    }
    
    //MARK: User
    static func getUser(completion: @escaping (User?, Int?, Error?) -> Void) {
        print(EndPoint.user.url)
        
        AF.request(EndPoint.user.url.absoluteString,
                   method: .get,
                   headers: commonHeader
        ).responseDecodable(of: User.self) { response in
            
            guard let statusCode = response.response?.statusCode else {
                return
            }
            switch response.result {
            case .success:
                completion(response.value, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
        }
    }
    
    static func withdrawUser(completion: @escaping (Int?, Error?) -> Void) {
        
        AF.request(EndPoint.withdraw.url,
                   method: .post,
                   headers: commonHeader
        ).responseString { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success:
                completion(statusCode, nil)
            case .failure(let error):
                completion(statusCode, error)
            }
        }
    }
    
    static func updateUser(updateUserDTO: UpdateMypageDTO ,completion: @escaping (Int?, Error?) -> Void) {
        
        let parameters: Parameters = [
            "searchable": updateUserDTO.searchable,
            "ageMin" : updateUserDTO.ageMin,
            "ageMax" : updateUserDTO.ageMax,
            "gender" : updateUserDTO.gender,
            "hobby" : updateUserDTO.hobby
        ]
        
        AF.request(EndPoint.withdraw.url,
                   method: .post,
                   parameters: parameters,
                   headers: commonHeader
        ).responseString { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success:
                completion(statusCode, nil)
            case .failure(let error):
                completion(statusCode, error)
            }
        }
    }
    
    //MARK: Queue
    static func onQueue(onqueueDTO: OnQueueDTO, completion: @escaping (OnQueueResult?, Int? , Error?) -> Void) {
        
        let parameters: Parameters = [
            "region": onqueueDTO.region,
            "lat": onqueueDTO.lat,
            "long": onqueueDTO.long
        ]
        
        AF.request(EndPoint.onQueue.url, method: .post, parameters: parameters, headers: commonHeader).responseDecodable(of: OnQueueResult.self) { response in
            
            print(response)
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .success(_):
                completion(response.value, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
            
        }
    }
    
    static func updateFCMToken(idToken: String, fcmToken: String, completion: @escaping (Int?) -> Void) {
           
           let parameters : Parameters = [
               "FCMtoken" : fcmToken
           ]
           
           AF.request(EndPoint.update_fcm_token.url, method: .put, parameters: parameters, headers: commonHeader).responseString { response in
               
               completion(response.response?.statusCode)
               
           }
           
       }
}


