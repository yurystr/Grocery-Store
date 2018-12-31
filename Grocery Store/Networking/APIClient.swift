import Foundation

enum APIError: Error {
    case requestFailed
    case responseUnsuccessful
    case noData
    case parsingFailure
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request failed"
        case .responseUnsuccessful: return "Response unsuccessful"
        case .noData: return "No data"
        case .parsingFailure: return "Parsing failed"
        }
    }
}

enum APIResult<T, E> where E: Error  {
    case success(T)
    case failure(E)
}

protocol APIClient {
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Data) -> T?, completion: @escaping (APIResult<T, APIError>) -> Void)
}

fileprivate struct APIConstants {
    static let httpResponseSuccessCode = 200
}

extension APIClient {
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Data) -> T?, completion: @escaping (APIResult<T, APIError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.requestFailed))
                    return
                }
                
                guard httpResponse.statusCode == APIConstants.httpResponseSuccessCode else {
                    completion(.failure(.responseUnsuccessful))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                if let value = decode(data) {
                    completion(.success(value))
                } else {
                    completion(.failure(.parsingFailure))
                }
            }
        }
        
        task.resume()
    }
}
