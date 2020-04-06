import Foundation
import SwiftyXMLParser
import SwiftSoup

class ParseUtils {
    
    static func getImgSrc(text: Document) -> String {
        if let elements = try? text.select("img").array(),
            let firstElement = elements.first,
            let url = try? firstElement.attr("src") {
            return url
        } else {
            return ""
        }
    }
    
    
}
