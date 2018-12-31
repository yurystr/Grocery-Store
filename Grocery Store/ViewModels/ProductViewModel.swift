import Foundation

class ProductViewModel {
    var title: String {
        return product.title
    }
    
    var subtitle: String {
        return product.price.description + " " + currency + " per " + product.unitOfMeasure
    }
    
    var countText: String {
        return String(count)
    }
    
    var onCountChanged: ((Int) -> Void)?
    
    private let product: Product
    private var count = 0
    private let currency: String
    
    init(product: Product, currency: String) {
        self.product = product
        self.currency = currency
    }
    
    func changeCount(count: Int) {
        self.count = count
        onCountChanged?(count)
    }
}
