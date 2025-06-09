//
//  NetworkManager.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/9/25.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    static private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Session(
            configuration: configuration
        )
    }()
}

extension NetworkManager {
    static func request(
        method: HTTPMethod,
        parameters: Parameters? = nil,
        url: String
    ) -> Observable<[String: Any]> {
        return Observable.create { observer in
            let request = NetworkManager.session
                .request(
                    url,
                    method: method,
                    parameters: parameters,
                    encoding: URLEncoding.default
                )
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                                observer.onNext(jsonObject)
                                observer.onCompleted()
                            } else {
                                let error = NSError(
                                    domain: "NetworkManager",
                                    code: -1,
                                    userInfo: [NSLocalizedDescriptionKey: "응답이 Dictionary 형태가 아닙니다."]
                                )
                                observer.onError(error)
                            }
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
