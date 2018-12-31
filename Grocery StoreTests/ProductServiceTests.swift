import XCTest
@testable import Grocery_Store

class ProductServiceTests: XCTestCase {
    func testProductListLoadingSuccess() {
        let productListExpectation = expectation(description: "Product list")
        ProductService().loadProductList(fileName: "TestProducts", bundle: Bundle(for: type(of: self))) { result in                        switch result {
            case .success(let productList):
                XCTAssertEqual(productList.products.count, 2)
                for (index, product) in productList.products.enumerated() {
                    XCTAssertEqual(product.title, String(index + 1))
                }
            case .failure(_):
                XCTFail()
            }
            productListExpectation.fulfill()
        }
        
        wait(for: [productListExpectation], timeout: 10)
    }
    
    func testProductListLoadingNoFile() {
        let productListExpectation = expectation(description: "Product list no file")
        ProductService().loadProductList(fileName: "NotExistingFile", bundle: Bundle(for: type(of: self))) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .noFile)
            }
            productListExpectation.fulfill()
        }
        
        wait(for: [productListExpectation], timeout: 10)
    }
    
    func testProductListParsingFailure() {
        let productListExpectation = expectation(description: "Product list corrupted data")
        ProductService().loadProductList(fileName: "TestProductsCorrupted", bundle: Bundle(for: type(of: self))) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .parsingFailure)
            }
            productListExpectation.fulfill()
        }
        
        wait(for: [productListExpectation], timeout: 10)
    }
}
