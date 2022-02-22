import Foundation
import Alamofire

class QueueAPIService {

    static func onQueue(onqueueDTO: OnQueueDTO, completion: @escaping (OnQueueResult?, Int?, Error?) -> Void) {

        let parameters: Parameters = [
            "region": onqueueDTO.region,
            "lat": onqueueDTO.lat,
            "long": onqueueDTO.long
        ]

        AF.request(EndPoint.onQueue.url,
                   method: .post,
                   parameters: parameters,
                   headers: commonHeader)
            .responseDecodable(of: OnQueueResult.self) { response in

            let statusCode = response.response?.statusCode

            switch response.result {
            case .success:
                completion(response.value, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
        }
    }

}
