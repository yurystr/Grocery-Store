import Foundation

class CurrencyListClient: APIClient {
    func getCurrencyList(completion: @escaping (APIResult<CurrencyList, APIError>) -> Void) {
        guard let url = URL(string: EndpointProvider().getPathFor(.currencyConverter)) else {
            return
        }
        
        let request = URLRequest(url: url)

        fetch(with: request, decode: { data -> CurrencyList? in
            do {
                return try JSONDecoder().decode(CurrencyList.self, from: data)
            } catch {
                return nil
            }
        }, completion: completion)
    }
}
