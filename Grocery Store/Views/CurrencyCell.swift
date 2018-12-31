import UIKit

class CurrencyCell: UITableViewCell {
    var viewModel: CurrencyViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    func setup(with viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        rateLabel.text = viewModel.rateText
    }
}
