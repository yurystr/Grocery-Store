import XCTest
@testable import Grocery_Store

class ApiClientMock: APIClient {
    
    var error: APIError?
    
    func testResponseFailure(completion: @escaping () -> Void) {
        
        guard let url = URL(string: "http://apilayer123.net/api/live") else {
            return
        }
        
        let request = URLRequest(url: url)
        
        fetch(with: request, decode: { data -> Decodable? in
            return nil
        }) { result in
            switch result {
            case .success(_):
                self.error = nil
            case .failure(let error):
                self.error = error
            }
            completion()
        }
    }
}

class APIClientTests: XCTestCase {
    func testResponseFailure() {
        
        let mock = ApiClientMock()
        let mockExpectation = expectation(description: "APIClientMock Expectation")
        mock.testResponseFailure {
            XCTAssertNotNil(mock.error)
            mockExpectation.fulfill()
        }
        
        wait(for: [mockExpectation], timeout: 10)
    }
}
