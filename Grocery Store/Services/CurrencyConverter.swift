import Foundation

class CurrencyConverter {
    static func convert(sum: Decimal, rate: Decimal) -> Decimal {
        return sum * rate
    }
}
