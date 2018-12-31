import Foundation

class CurrencyConverterClient: APIClient {
    func getConverter(completion: @escaping (APIResult<CurrencyConverter, APIError>) -> Void) {
        guard let url = URL(string: EndpointProvider().getPathFor(.currencyConverter)) else {
            return
        }
        
        let request = URLRequest(url: url)

        fetch(with: request, decode: { data -> CurrencyConverter? in
            do {
                return try JSONDecoder().decode(CurrencyConverter.self, from: data)
            } catch {
                return nil
            }
        }, completion: completion)
    }
}
