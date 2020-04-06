import Foundation

class DateUtils {
    
    static func getDateFromString(dateString: String, formate: String, localeIdentifier: String = "en_US_POSIX") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.dateFormat = formate
        let date = dateFormatter.date(from: dateString)
        
        return date
    }
    
    static func getStringFromDate(date: Date?, formate: String, localeIdentifier: String = "ru_RU") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier)
        dateFormatter.dateFormat = formate
        if let date = date {
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    
}
