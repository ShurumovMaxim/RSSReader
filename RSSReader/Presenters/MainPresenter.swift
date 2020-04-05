import Foundation

protocol MainPresenterDelegate: class {
    
}

class MainPresenter {
    
    weak private var delegate: MainPresenterDelegate?
    
    private let mainService: MainService
    
    init(mainService: MainService){
        self.mainService = mainService
        mainService.getHabrXML()
    }
    
    func setDelegate(_ mainPresenterDelegate: MainPresenterDelegate?){
        self.delegate = mainPresenterDelegate
    }
    
    
}
