import Foundation

protocol BasketProtocol {
    var productList: ProductList? { get set }
    
    func update(count: Int, for product: Product)
    func getTotalCount() -> Int
    func getTotalSum() -> Decimal
    func getCurrency() -> String
}

class Basket: BasketProtocol {
    var productList: ProductList?
    var products = [String: Int]()
    
    func update(count: Int, for product: Product) {
        if count == 0 {
            products.removeValue(forKey: product.identifier)
            return
        }
        products.updateValue(count, forKey: product.identifier)
    }
    
    func getTotalCount() -> Int {
        return products.values.reduce(0, +)
    }
    
    func getTotalSum() -> Decimal {
        guard let productList = productList else {
            return 0
        }
        var sum = Decimal(0)
        for key in products.keys {
            if let product = productList.getProduct(by: key),
                let count = products[key] {
                sum += product.price * Decimal(count)
            }
        }
        
        return sum
    }
    
    func getCurrency() -> String {
        return productList?.currency ?? ""
    }
}
