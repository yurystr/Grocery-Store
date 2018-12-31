import Foundation

protocol ProductListProtocol {
    var products: [Product] { get set }
    var currency: String { get set }
    
    func getProduct(by identifier: String) -> Product?
}

struct ProductList: Decodable, ProductListProtocol {
    var products: [Product]
    var currency: String
    
    func getProduct(by identifier: String) -> Product? {
        return products.first(where: {$0.identifier == identifier})
    }
}

struct Product: Decodable {
    let identifier: String
    let title: String
    let price: Decimal
    let unitOfMeasure: String
}
