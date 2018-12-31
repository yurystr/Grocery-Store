import XCTest
@testable import Grocery_Store

class CurrencyViewModelTests: XCTestCase {
    func testCurrencyTitle() {
        let currency = Currency(title: "Test currency", rate: 3.14)
        let viewModel = CurrencyViewModel(currency: currency)
        XCTAssertEqual(viewModel.title, "Test currency")
    }
    
    func testCurrencyRateText() {
        let currency = Currency(title: "Test currency", rate: 3.14)
        let viewModel = CurrencyViewModel(currency: currency)
        XCTAssertEqual(viewModel.rateText, "3.14")
    }
}
