import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    
    var viewModel = ProductListViewModel()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView(frame: .zero)
        
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.barButtonItem.isEnabled = false
        self.barButtonItem.isEnabled = self.viewModel.isCheckoutEnabled
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let checkoutViewController = segue.destination as? CheckoutViewController {
            checkoutViewController.viewModel = viewModel.buildCheckoutViewModel()
        }
    }
    
    // MARK: - Private methods
    private func setupViewModel() {
        viewModel.onDataFailed = { [weak self] errorText in
            self?.showAlert(text: errorText)
        }
        
        viewModel.onDataUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.onTotalUpdated = { [weak self] in
            guard let `self` = self else {
                return
            }
            self.barButtonItem.title = self.viewModel.checkoutText
            self.barButtonItem.isEnabled = self.viewModel.isCheckoutEnabled
        }
        
        viewModel.loadData()
    }
}

extension ProductListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.cellIdentifier(), for: indexPath)
        if let productCell = cell as? ProductCell {
            productCell.setup(with: viewModel.productViewModels[indexPath.row])
        }
        
        return cell
    }
}
