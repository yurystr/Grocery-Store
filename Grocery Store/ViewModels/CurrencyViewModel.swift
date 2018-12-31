import Foundation

class CurrencyViewModel {
    
    var title: String {
        return currency.title
    }
    
    var rateText: String {
        return currency.rate.toStringTruncated()
    }
    
    public private(set) var currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
}
