import Foundation
import Alamofire

class QueueAPIService {

    static func requestFriends(request: QueueRequest, completion: @escaping (Int?, Error?) -> Void) {

        AF.request(QueueTarget.queue(request))
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    static func stopRequestFriends(completion: @escaping (Int?, Error?) -> Void) {
        AF.request(QueueTarget.queueStop)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    static func searchNearFriends(request: OnQueueRequest, completion: @escaping (OnQueueResponse?, Int?, Error?) -> Void) {
        AF.request(QueueTarget.onQueue(request))
            .responseDecodable(of: OnQueueResponse.self) { response in
                switch response.result {
                case .success:
                    completion(response.value, response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, nil, error)
                }
            }
    }

    static func requestHobby(request: OtherUser, completion: @escaping (Int?, Error?) -> Void) {

        AF.request(QueueTarget.hobbyRequest(request))
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    static func acceptHobby(request: OtherUser, completion: @escaping (Int?, Error?) -> Void) {

        AF.request(QueueTarget.hobbyAccept(request))
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    static func myQueueState(completion: @escaping (MyQueueStateResponse?, Int?, Error?) -> Void) {

        AF.request(QueueTarget.myQueueState)
            .responseDecodable(of: MyQueueStateResponse.self) { response in
                switch response.result {
                case .success:
                    completion(response.value, response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, nil, error)
                }
            }
    }

    static func dodge(request: OtherUser, completion: @escaping (Int?, Error?) -> Void) {

        AF.request(QueueTarget.dodge(request))
            .responseString { response in
                switch response.result {
                case .success:
                    completion(response.response?.statusCode, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    static func rate(request: RateRequest, completion: @escaping (Int?, Error?) -> Void) {

        AF.request(QueueTarget.rate(request))
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
