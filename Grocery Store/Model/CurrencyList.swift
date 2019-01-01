import Foundation

protocol CurrencyListProtocol {
    var source: String { get set }
    var quotes: [String: Decimal] { get set }
}

struct CurrencyList: Decodable, CurrencyListProtocol {
    var source: String
    var quotes: [String: Decimal]
}
