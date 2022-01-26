//
//  APIService.swift
//  SLP
//
//  Created by Kanghos on 2022/01/20.
//

import Foundation

enum Method: String {
    case GET, POST, PUT, DELETE
}

enum EndPoint {
    case register
    case update_fcm_token
    case update_mypage
    case withdraw
}

extension EndPoint {
    var url: URL {
        switch self {
        case .register:
            return .makeEndpoint("/user")
        case .update_fcm_token:
            return .makeEndpoint("/user/update_fcm_token")
        case .update_mypage:
            return .makeEndpoint("/user/update/mypage")
        case .withdraw:
            return .makeEndpoint("/user/withdraw")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:35484"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult //반환값 사용 안 함
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping(T?, APIError?) -> Void){
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
