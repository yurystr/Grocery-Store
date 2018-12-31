import XCTest
@testable import Grocery_Store

class ProductListViewModelTests: XCTestCase {
    func testCheckoutTextEmpty() {
        let viewModel = ProductListViewModel()
        XCTAssertEqual(viewModel.checkoutText, "Checkout")
    }
    
    func testCheckout() {
        let basket = Basket()
        let product = Product(identifier: "1", title: "Test 1", price: 1, unitOfMeasure: "Test UoM")
        basket.productList = ProductList(products: [product], currency: "Test currency")
        
        let viewModel = ProductListViewModel(basket: basket)
        basket.update(count: 10, for: product)
        
        XCTAssertEqual(viewModel.checkoutText, "Checkout (10)")
    }
    
    func testCheckoutEnabledEmpty() {
        let viewModel = ProductListViewModel()
        XCTAssertEqual(viewModel.isCheckoutEnabled, false)
    }
    
    func testCheckoutEnabled() {
        let basket = Basket()
        let product = Product(identifier: "1", title: "Test 1", price: 1, unitOfMeasure: "Test UoM")
        basket.productList = ProductList(products: [product], currency: "Test currency")
        
        let viewModel = ProductListViewModel(basket: basket)
        basket.update(count: 10, for: product)
        
        XCTAssertEqual(viewModel.isCheckoutEnabled, true)
    }
}
