import Foundation

enum Endpoint {
    case currencyConverter
}

class EndpointProvider {
    struct Constants {
        static let basePath = "http://apilayer.net/api/live"
        static let accessKey = "0942ab3783773407dbcd9971f39845bf"
    }

    func getPathFor(_ endpoint: Endpoint) -> String {
        switch endpoint {
        case .currencyConverter:
            return Constants.basePath + "?access_key=" + Constants.accessKey
        }
    }
}
