import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let presenter = MainPresenter(mainService: MainService())
    
    private let tableView = UITableView()
    
    private let identifier = "NewsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setDelegate(self)
        
        setupElements()
        addSubviews()

        view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupElements() {
        view.backgroundColor = .green
        
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 45
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }


}

// MARK: - MainPresenterDelegate

extension MainViewController: MainPresenterDelegate {
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! NewsTableViewCell
        return cell
    }
    
    
}
