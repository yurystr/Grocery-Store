import UIKit

class ProductCell: UITableViewCell {
    var viewModel: ProductViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func setup(with viewModel: ProductViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        countLabel.text = viewModel.countText
    }
    
    // MARK: - Actions
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        viewModel.changeCount(count: Int(sender.value))
        countLabel.text = viewModel.countText
    }
}
