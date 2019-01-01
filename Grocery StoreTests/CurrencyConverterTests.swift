import XCTest
@testable import Grocery_Store

class CurrencyConverterTests: XCTestCase {
    func testConverter() {
        let sum = Decimal(10)
        let rate = Decimal(1.5)
        XCTAssertEqual(sum * rate, CurrencyConverter.convert(sum: sum, rate: rate))
    }
}
