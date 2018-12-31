import Foundation

class ProductListViewModel {
    struct Constants {
        static let checkout = "Checkout"
    }
    
    var onDataUpdated: (() -> Void)?
    var onDataFailed: ((String) -> Void)?
    var onTotalUpdated: (() -> Void)?
    var productViewModels = [ProductViewModel]()
    
    var checkoutText: String {
        var text = Constants.checkout
        let count = basket.getTotalCount()
        if count > 0 {
            text += " (\(count))"
        }
        
        return text
    }
    
    var isCheckoutEnabled: Bool {
        return basket.getTotalCount() > 0
    }
    
    private var basket: BasketProtocol
    
    init(basket: BasketProtocol = Basket()) {
        self.basket = basket
    }
    
    func loadData() {
        ProductService().loadDefaultProductList { [weak self] result in
            switch result {
            case .success(let productList):
                self?.basket.productList = productList
                self?.buildViewModels()
            case .failure(let error):
                self?.onDataFailed?(error.localizedDescription)
            }
        }
    }
    
    func buildCheckoutViewModel() -> CheckoutViewModel {
        return CheckoutViewModel(basket: basket)
    }
    
    // MARK: - Private methods
    private func buildViewModels() {
        guard let products = basket.productList?.products else {
            return
        }
        
        guard let currency = basket.productList?.currency else {
            return
        }
        
        productViewModels = []
        for product in products {
            let productViewModel = ProductViewModel(product: product, currency: currency)
            productViewModel.onCountChanged = { [weak self] count in
                guard let `self` = self else {
                    return
                }
                
                self.basket.update(count: count, for: product)
                self.onTotalUpdated?()
            }
            productViewModels.append(productViewModel)
        }
        
        onDataUpdated?()
    }
}
