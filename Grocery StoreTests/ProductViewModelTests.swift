import XCTest
@testable import Grocery_Store

class ProductViewModelTests: XCTestCase {
    func testTitle() {
        let product = Product(identifier: "1", title: "Test 1", price: 1, unitOfMeasure: "Test UoM")
        let viewModel = ProductViewModel(product: product, currency: "Test currency")
        XCTAssertEqual(viewModel.title, "Test 1")
    }
    
    func testSubtitle() {
        let product = Product(identifier: "1", title: "Test 1", price: 1, unitOfMeasure: "Test UoM")
        let viewModel = ProductViewModel(product: product, currency: "Test currency")
        XCTAssertEqual(viewModel.subtitle, "1 Test currency per Test UoM")
    }
    
    func testCount() {
        let product = Product(identifier: "1", title: "Test 1", price: 1, unitOfMeasure: "Test UoM")
        let viewModel = ProductViewModel(product: product, currency: "Test currency")
        viewModel.countChanged(count: 10)
        XCTAssertEqual(viewModel.countText, "10")
    }
}
