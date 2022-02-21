//
//  APIService.swift
//  SLP
//
//  Created by Kanghos on 2022/01/20.
//

import Foundation

enum Token {
    case idToken
    case fcmToken
}

extension Token {
    var token: String {
        switch self {
        case .idToken:
            return UserDefaults.standard.string(forKey: "idToken")!
        case .fcmToken:
            return UserDefaults.standard.string(forKey: "fcmToken")!
        }
    }
}

enum Method: String {
    case GET, POST, PUT, DELETE
}

enum URI: String {
    case user = "/user"
    case queue = "/queue"
}

enum EndPoint {
    case user
    case update_fcm_token
    case update_mypage
    case withdraw
    case onQueue
    case postQueue
    
}

extension EndPoint {
    var url: URL {
        switch self {
        case .user:
            return .makeUserEndpoint("")
        case .update_fcm_token:
            return .makeUserEndpoint("/update_fcm_token")
        case .update_mypage:
            return .makeUserEndpoint("/update/mypage")
        case .withdraw:
            return .makeUserEndpoint("/withdraw")
        case .onQueue:
            return .makeQueueEndpoint("")
        case .postQueue:
            return .makeQueueEndpoint("")
        }
    
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:35484"
    
    static func makeUserEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + URI.user.rawValue + endpoint)!
    }
    static func makeQueueEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + URI.queue.rawValue + endpoint)!
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping(T?, APIError?) -> Void) {
        URLSession.shared.dataTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    
                    print(response.statusCode)
                    if response.statusCode == 401 {
                        completion(nil, .tokenExpired)
                    } else {
                        completion(nil, .failed)
                    }
                    return
                }
                
                do {
                    print(response.statusCode)
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil)
                } catch {
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
