import XCTest
@testable import Grocery_Store

class BasketTests: XCTestCase {
    func testCurrencyEmpty() {
        let basket = Basket()
        XCTAssertEqual(basket.getCurrency(), "")
    }
    
    func testCurrency() {
        let basket = Basket()
        basket.productList = ProductList(products: [], currency: "TestCurrency")
        XCTAssertEqual(basket.getCurrency(), "TestCurrency")
    }
    
    func testTotalCount() {
        let basket = Basket()
        basket.update(count: 10, for: Product(identifier: "1", title: "Test", price: 0, unitOfMeasure: "Test UoM"))
        XCTAssertEqual(basket.getTotalCount(), 10)
    }
    
    func testTotalSum() {
        let basket = Basket()
        let product1 = Product(identifier: "1", title: "Test 1", price: 1, unitOfMeasure: "Test UoM")
        let product2 = Product(identifier: "2", title: "Test 2", price: 2, unitOfMeasure: "Test UoM")
        basket.productList = ProductList(products: [product1, product2], currency: "Test currency")
        basket.update(count: 10, for: product1)
        basket.update(count: 10, for: product2)
        XCTAssertEqual(basket.getTotalSum(), 30)
    }
}
