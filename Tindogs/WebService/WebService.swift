//
//  WebService.swift
//  Tindogs
//
//  Created by Jose Luis Solis Pino on 30/3/18.
//  Copyright © 2018 Appvengers. All rights reserved.
//

import Foundation
import RxSwift

internal enum WebServiceError: Error {
    case badStatus(Int, Data)
    case api(Int, String)
}

private struct Status: Decodable {
    let code: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }
}

final internal class WebService {
    private let configuration: WebServiceConfiguration
    private let session = URLSession(configuration: .default)
    private let baseURL = URL(string: "http://34.239.83.44:3000/apiv1")!
    private let decoder = JSONDecoder()
    
    init(configuration: WebServiceConfiguration) {
        self.configuration = configuration
    }
    
    func load<T>(_ type: T.Type, from endpoint: Endpoint) -> Observable<T> where T: Decodable {
        let decoder = self.decoder
        let request = endpoint.request(with: baseURL)
        
        print("request: \(request)")
        print("method: \(String(describing: request.httpMethod))")
        print("body \(String(describing: request.httpBody))")
        
        return session.rx.data(request: request)
            .map { try decoder.decode(T.self, from: $0) }
            .catchError { error in
                guard let webServiceError = error as? WebServiceError else {
                    throw error
                }
                
                guard case let .badStatus(_, data) = webServiceError else {
                    throw error
                }
                
                guard let status = try? decoder.decode(Status.self, from: data) else {
                    throw error
                }
                
                throw WebServiceError.api(status.code, status.message)
            }
    }
}

private extension Reactive where Base: URLSession {
    func data(request: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("onError")
                    observer.onError(error)
                } else {
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        fatalError("Unsupported protocol")
                    }
                    print("httpResponse \(httpResponse)")
                    if 200 ..< 300 ~= httpResponse.statusCode {
                        if let data = data {
                            observer.onNext(data)
                            print("data: \(data)")
                        }
                        observer.onCompleted()
                    } else {
                        observer.onError(WebServiceError.badStatus(httpResponse.statusCode, data ?? Data()))
                    }
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
