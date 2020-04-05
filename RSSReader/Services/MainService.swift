import Foundation
import Alamofire
import SwiftyXMLParser

class MainService {
    
    func getNews(completion: @escaping ([NewsModel]) -> ()) {
        var allNews = [NewsModel]()
        
        getHabrNews() { (habrNews) in
            allNews += habrNews
            
            self.getRedditNews() { (redditNews) in
                allNews += redditNews
                allNews = allNews.sorted(by: { $0.date!.compare($1.date!) == .orderedDescending})
                completion(allNews)
            }
        }
    }
    
    func getHabrNews(completion: @escaping ([NewsModel]) -> ()) {
        Alamofire.request("https://habr.com/rss/hubs/all").responseData { response in
            if let data = response.data {
                let xml = XML.parse(data)
                
                var newsItems = [NewsModel]()
                for item in xml.rss.channel.item {
                    let news = NewsModel(newsSource: .habr, xml: item)
                    newsItems.append(news)
                }
                
                completion(newsItems)
            }
        }
    }
    
    func getRedditNews(completion: @escaping ([NewsModel]) -> ()) {
        Alamofire.request("https://www.reddit.com/.rss").responseData { response in
            if let data = response.data {
                let xml = XML.parse(data)
                
                var newsItems = [NewsModel]()
                for item in xml.feed.entry {
                    let news = NewsModel(newsSource: .reddit, xml: item)
                    newsItems.append(news)
                }
                
                completion(newsItems)
            }
        }
    }
    
    
}
