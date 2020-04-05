import Foundation

protocol MainPresenterDelegate: class {
    func updateTableView(news: [NewsModel])
}

class MainPresenter {
    
    weak private var delegate: MainPresenterDelegate?
    
    private let mainService: MainService
    
    init(mainService: MainService){
        self.mainService = mainService
        
        mainService.getNews { (news) in
            self.delegate?.updateTableView(news: news)
        }
//        mainService.getHabrNews { (news) in
////            self.delegate?.updateTableView(news: news)
//        }
//        mainService.getRedditNews { (news) in
//            self.delegate?.updateTableView(news: news)
//        }
    }
    
    func setDelegate(_ mainPresenterDelegate: MainPresenterDelegate?){
        self.delegate = mainPresenterDelegate
    }
    
    
}
