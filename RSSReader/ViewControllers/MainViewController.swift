import UIKit
import SnapKit

class MainViewController: UIViewController{

    private let presenter = MainPresenter(mainService: MainService())
    
    private let tableView = UITableView()
    
    private var news = [NewsModel]()
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
        view.backgroundColor = .white
        
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
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
    
    func updateTableView(news: [NewsModel]) {
        self.news = news
        tableView.reloadData()
    }
    
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! NewsTableViewCell
        
        cell.delegate = self
        cell.setElements(news: news[indexPath.row])
        
        return cell
    }
    
    
}

// MARK: - NewsTableViewCellDelegate

extension MainViewController: NewsTableViewCellDelegate {
    
    func descriptionHidden() {
        tableView.reloadData()
    }
    
    
}
