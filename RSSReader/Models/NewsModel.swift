import SwiftyXMLParser
import SwiftSoup

enum NewsSource: String {
    case habr = "Хабр"
    case reddit = "Reddit"
    case meduza = "Meduza"
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
                imageUrl = ParseUtils.getImgSrc(text: descriptionDocument)

                if let text = try? descriptionDocument.text() {
                    description = text.withoutReadMore
                }
            }
            
            source = newsSource
            date = DateUtils.getDateFromString(dateString: xml.pubDate.text ?? "",
                                               formate: "E, d MMM yyyy HH:mm:ss Z")
            
        case .reddit:
            title = xml.title.text ?? ""
            
            if let descriptionXml = xml.content.text,
                let descriptionDocument: Document = try? SwiftSoup.parse(descriptionXml) {
                imageUrl = ParseUtils.getImgSrc(text: descriptionDocument)
            }
            
            source = newsSource
            date = DateUtils.getDateFromString(dateString:  xml.updated.text ?? "",
                                               formate: "yyyy-MM-dd'T'HH:mm:ssZ")
            
        case .meduza:
            title = xml.title.text ?? ""
            description = xml["description"].text ?? ""
            imageUrl = xml["itunes:image"].attributes["href"] ?? ""
            source = newsSource
            date = DateUtils.getDateFromString(dateString: xml.pubDate.text ?? "",
                                               formate: "E, d MMM yyyy HH:mm:ss Z")

        }
        
    }
    
    
}
