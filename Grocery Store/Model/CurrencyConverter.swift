import Foundation

protocol CurrencyConverterProtocol {
    var source: String { get set }
    var quotes: [String: Decimal] { get set }
}

class CurrencyConverter: Decodable, CurrencyConverterProtocol {
    var source: String
    var quotes: [String: Decimal]
}
