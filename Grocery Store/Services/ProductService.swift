import Foundation

class ProductService {
    enum Result<T, E> where E: Error  {
        case success(T)
        case failure(E)
    }
    
    enum LoadError: Error {
        case noFile
        case parsingFailure
        
        var localizedDescription: String {
            switch self {
            case .noFile: return "File does not exist"
            case .parsingFailure: return "Failed to parse products"
            }
        }
    }
    
    func loadDefaultProductList(completion: @escaping (Result<ProductList, LoadError>) -> Void) {
        loadProductList(fileName: "Products", bundle: Bundle.main, completion: completion)
    }
    
    func loadProductList(fileName: String, bundle: Bundle, completion: @escaping (Result<ProductList, LoadError>) -> Void) {
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            completion(.failure(.noFile))
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let productList = try JSONDecoder().decode(ProductList.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(productList))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.parsingFailure))
                }
            }
        }
    }
}
