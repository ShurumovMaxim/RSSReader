import Foundation
import Alamofire
import SwiftyXMLParser

class MainService {
    
    func getHabrXML(completion: @escaping ([NewsModel]) -> ()) {
        Alamofire.request("https://habr.com/rss/hubs/all").responseData { response in
            if let data = response.data {
                let xml = XML.parse(data)
                
                var newsItems = [NewsModel]()
                for item in xml.rss.channel.item {
                    let news = NewsModel(xml: item)
                    newsItems.append(news)
                }
                
                completion(newsItems)
            }
        }
    }
    
    
}
