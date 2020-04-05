import Foundation

extension String {
    
    var withoutReadMore: String {
        return self.replacingOccurrences(of: "Читать дальше →",
                                         with: "",
                                         options:.regularExpression,
                                         range: nil)
    }

    
}
