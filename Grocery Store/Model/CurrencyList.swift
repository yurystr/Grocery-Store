import Foundation

protocol CurrencyListProtocol {
    var source: String { get set }
    var quotes: [String: Decimal] { get set }
}

class CurrencyList: Decodable, CurrencyListProtocol {
    var source: String
    var quotes: [String: Decimal]
}
