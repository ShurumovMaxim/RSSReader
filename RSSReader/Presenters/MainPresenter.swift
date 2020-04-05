import Foundation

protocol MainPresenterDelegate: class {
    
}

class MainPresenter {
    
    weak private var delegate: MainPresenterDelegate?
    
    func setDelegate(_ mainPresenterDelegate: MainPresenterDelegate?){
        self.delegate = mainPresenterDelegate
    }
    
    
}
