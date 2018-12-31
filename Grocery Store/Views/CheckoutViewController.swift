import UIKit

class CheckoutViewController: UIViewController {
    var viewModel: CheckoutViewModel!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var convertLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        setupControls()
        setupViewModel()
    }
    
    // MARK: - Private methods
    private func setupControls() {
        totalLabel.text = viewModel.totalText
        convertLabel.text = viewModel.convertText
    }
    
    private func setupViewModel() {
        viewModel.onDataFailed = { [weak self] errorText in
            self?.activityIndicatorView.isHidden = true
            self?.showAlert(text: errorText)
        }
        
        viewModel.onDataUpdated = { [weak self] in
            self?.activityIndicatorView.isHidden = true
            self?.tableView.reloadData()
        }
        
        viewModel.onTotalConverted = { [weak self] in
            guard let `self` = self else {
                return
            }
            
            self.totalLabel.text = self.viewModel.totalText
        }
        
        viewModel.loadData()
    }
}

extension CheckoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.cellIdentifier(), for: indexPath)
        if let currencyCell = cell as? CurrencyCell {
            currencyCell.setup(with: viewModel.currencyViewModels[indexPath.row])
        }
        
        return cell
    }
}

extension CheckoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCurrencyViewModel(viewModel.currencyViewModels[indexPath.row])
    }
}
