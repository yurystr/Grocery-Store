import UIKit

extension UITableViewCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

extension UIViewController {
    func showAlert(text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Decimal {
    func toStringTruncated() -> String {
        return String(format: "%.2f", Double(truncating: self as NSNumber))
    }
}
