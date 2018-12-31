import XCTest
@testable import Grocery_Store

class CheckoutViewModelTests: XCTestCase {
    func testTotalText() {
        let basket = Basket()
        let product = Product(identifier: "1", title: "Test 1", price: 1, unitOfMeasure: "Test 1")
        basket.productList = ProductList(products: [product], currency: "Test currency")
        basket.update(count: 10, for: product)
        
        let viewModel = CheckoutViewModel(basket: basket)
        XCTAssertEqual(viewModel.totalText, "Your total is: 10 Test currency")
    }
}
