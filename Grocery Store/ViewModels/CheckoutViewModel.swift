import Foundation

class CheckoutViewModel {
    struct Constants {
        static let yourTotal = "Your total is:"
        static let convertText = "The price can be converted:"
    }
    
    var totalText: String {
        if let currency = selectedCurrency {
            let converted = CurrencyConverter.convert(sum: basket.getTotalSum(), rate: currency.rate)
            let convertedString = converted.toStringTruncated()
            return Constants.yourTotal + " " + convertedString + " " + currency.title
        } else {
            return Constants.yourTotal + " " + "\(basket.getTotalSum())" + " " + basket.getCurrency()
        }
    }
    
    var convertText: String {
        return Constants.convertText
    }
    
    var onDataUpdated: (() -> Void)?
    var onDataFailed: ((String) -> Void)?
    var onTotalConverted: (() -> Void)?
    
    var currencyViewModels = [CurrencyViewModel]()
    
    private var basket: BasketProtocol
    private var currencyList: CurrencyListProtocol?
    private var selectedCurrency: Currency?
    
    init(basket: BasketProtocol, currencyList: CurrencyListProtocol? = nil) {
        self.basket = basket
        self.currencyList = currencyList
    }
    
    func loadData() {
        CurrencyListClient().getCurrencyList { [weak self] result in
            switch result {
            case .success(let currencyList):
                self?.currencyList = currencyList
                self?.buildViewModels()
            case .failure(let error):
                self?.onDataFailed?(error.localizedDescription)
            }
        }
    }
    
    func selectCurrencyViewModel(_ currencyViewModel: CurrencyViewModel) {
        selectedCurrency = currencyViewModel.currency
        onTotalConverted?()
    }
    
    // MARK: - Private methods
    private func buildViewModels() {
        guard let currencyList = currencyList else {
            return
        }
        
        currencyViewModels = []
        for (currency, rate) in currencyList.quotes {
            let currencyTruncated = self.truncatedCurrencyString(from: currency, source: currencyList.source)
            let currencyViewModel = CurrencyViewModel(currency: Currency(title: currencyTruncated, rate: rate))
            currencyViewModels.append(currencyViewModel)
        }
        
        onDataUpdated?()
    }
    
    // The Currency API responds in the format of "[Source][Currency]" (e.g. USDEUR), so we need
    // to truncate the source part for a better readability
    private func truncatedCurrencyString(from currency: String, source: String) -> String {
        var currencyTruncated = currency.replacingOccurrences(of: source, with: "")
        if currencyTruncated == "" {
            currencyTruncated = source
        }
        
        return currencyTruncated
    }
}
