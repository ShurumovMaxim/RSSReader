import SwiftyXMLParser
import SwiftSoup

class NewsModel {
    
    let title: String
    var description: String = ""
    var imageUrl: String = ""
    let source: String
    let date: Date?
    var descriptionIsHidden: Bool = true

    init(xml: XML.Accessor) {
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
        
        source = xml.link.text ?? ""
        
        let dateString = xml.pubDate.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.date(from: dateString)
        self.date = date
    }
    
    
}
