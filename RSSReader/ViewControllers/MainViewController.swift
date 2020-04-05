import UIKit

class MainViewController: UIViewController {
    
    private let presenter = MainPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setDelegate(self)
        
        view.backgroundColor = .green
        
        // Do any additional setup after loading the view.
    }


}

// MARK: - MainPresenterDelegate

extension MainViewController: MainPresenterDelegate {
    
}

