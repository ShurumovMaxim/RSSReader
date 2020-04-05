import Foundation
import Alamofire
import SwiftyXMLParser

class MainService {
    
    func getHabrXML() {
        Alamofire.request("https://habr.com/rss/hubs/all").responseData { response in
            if let data = response.data {
                let xml = XML.parse(data)
                for item in xml.rss.channel.item {
                    print(item.title.text)
                }
            }
        }
    }
    
    
}
