import SwiftyXMLParser
import SwiftSoup

enum NewsSource: String {
    case habr = "Хабр"
    case reddit = "Reddit"
}

class NewsModel {
    
    let title: String
    var description: String = ""
    var imageUrl: String = ""
    let source: NewsSource
    let date: Date?
    var descriptionIsHidden: Bool = true

    init(newsSource: NewsSource, xml: XML.Accessor) {
        
        switch newsSource {
        case .habr:
            title = xml.title.text ?? ""
            
            if let descriptionXml = xml["description"].text,
                let descriptionDocument: Document = try? SwiftSoup.parse(descriptionXml) {
                if let elements = try? descriptionDocument.select("img").array(),
                    let firstElement = elements.first,
                    let url = try? firstElement.attr("src") {
                    imageUrl = url
                }

                if let text = try? descriptionDocument.text() {
                    description = text.withoutReadMore
                }
            }
            
            source = newsSource
            
            let dateString = xml.pubDate.text ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
            let date = dateFormatter.date(from: dateString)
            self.date = date
            
        case .reddit:
            title = xml.title.text ?? ""
            
            if let descriptionXml = xml.content.text,
                let descriptionDocument: Document = try? SwiftSoup.parse(descriptionXml) {
                if let elements = try? descriptionDocument.select("img").array(),
                    let firstElement = elements.first,
                    let url = try? firstElement.attr("src") {
                    imageUrl = url
                }
            }
            
            source = newsSource
            
            let dateString = xml.updated.text ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: dateString)
            self.date = date
        }
        
    }
    
    
}
