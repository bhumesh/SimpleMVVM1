//
//  DataFetcher.swift
//  JarusAssigment
//
//  Created by BhumeshwerKatre on 11/04/21.
//

import Foundation
protocol DataFetcherProtocol {
    func getDataForRequest<T: Codable>(_ request: String, completion: @escaping(Result<T, APIError>) -> Void)
}
class DataFetcher: DataFetcherProtocol {
    private lazy var operationQueue: OperationQueue = {
      var queue = OperationQueue()
      queue.name = "Data_Fetcher_Queue"
      queue.maxConcurrentOperationCount = 1
      return queue
    }()
    func getDataForRequest<T: Codable>(_ request: String, completion: @escaping (Result<T, APIError>) -> Void) {
        let operation = DataFetcherOperation<T>(request)
        operation.completionBlock = {
            if operation.isCancelled {
                completion(.failure(.requestCancelled))
                return
            }
            if let result = operation.result {
                completion(result)
            } else {
                completion(.failure(.noData))
            }
        }
        self.operationQueue.addOperation(operation)
    }
}
enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
enum APIError: Error {
    case requestCancelled
    case jsonParsingFailure
    case requestFailed(Error?, [String: Any]? = nil)
    case noData
}
class DataFetcherOperation<T: Codable>: Operation {
    let request: String
    var result: Result<T, APIError>?
    init(_ request: String) {
        self.request = request
    }
    
    override func main() {
        if isCancelled {
            return
        }
        if let path = Bundle.main.path(forResource: "assignment", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonDecoder = JSONDecoder()
                if let response = try jsonDecoder.decode(T?.self, from: data) {
                    self.result = .success(response)
                } else {
                    self.result = .failure(.noData)
                }
            } catch {
                self.result = .failure(.jsonParsingFailure)
            }
        }
    }
}
