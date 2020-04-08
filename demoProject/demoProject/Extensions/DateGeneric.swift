
import Foundation

enum dateFormats {
    
    case birthdayApp
    case birthdayServer
    case storeDate
    case uploadPic
    case facebookServer

    case DayHour24
    case DayHour12

    case weightUpdateTimeServer
    
    case snapFormat
    case weekDayName
    
    case hitsResponseDate
    case hitsDisplayDate

    var text:String{
        
        switch self {
        case .birthdayApp ,.facebookServer:
            return "MM/dd/yyyy"
        case .birthdayServer, .weightUpdateTimeServer, .storeDate:
            return "MM/dd/yyyy hh:mm:ss a"
        case .uploadPic:
            return "yyyyMMdd_HHmmss"
        case .snapFormat:
            return "MMMM dd, yyyy"
        case .DayHour24:
            return "HH:mm"
        case .DayHour12:
            return "hh:mm a"
        case .weekDayName:
            return "EEEE"
        case .hitsResponseDate:
            return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .hitsDisplayDate:
            return "E, dd MMMM yyyy HH:mm:ss a"
        }
    }
}
struct DateExtension {
    
    static func date(fromString stringDate:String ,withFormat format:dateFormats) -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.text
        formatter.locale = Locale(identifier: "en_US_POSIX") // For time format.
        formatter.timeZone = TimeZone(abbreviation:"UTC") // for calculate time.
        
        if let date = formatter.date(from: stringDate){
            return date
        }
        return nil
    }
    static func dateLocal(fromString stringDate:String ,withFormat format:dateFormats) -> Date? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format.text
        formatter.locale = Locale(identifier: "en_US_POSIX") // For time format.
        formatter.timeZone = TimeZone.current // for calculate time.
        
        if let date = formatter.date(from: stringDate){
            return date
        }
        return nil
    }
    
    static func string(fromDate date:Date, withFormat format:dateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.text
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation:"UTC")
        return formatter.string(from: date)
    }
    
    static func stringWithLocalTime(fromDate date:Date, withFormat format:dateFormats) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.text
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        return formatter.string(from: date)
    }
    
    static func changeDateformatterForString(fromDate dateString: String, currentFormat: dateFormats, with format: dateFormats) -> String {
        if let date = self.date(fromString: dateString, withFormat: currentFormat) {
            return string(fromDate: date, withFormat: format)
        }
        return ""
    }
    
}
