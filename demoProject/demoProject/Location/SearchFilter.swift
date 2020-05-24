
import CoreData

enum SearchType: Int {
    case none
    case text
    case location
}

enum SearchFor: Int {
    case none
    case service
    case project
    case applicant
}

struct UserSearchData {
    var address1        : Generic?
    var address2        : Generic?
    var city            : Generic?
    var lat             : Generic?
    var long            : Generic?
    var searchText      : Generic?
    var searchType      = SearchType.none
    var searchFor       = SearchFor.none
    var state           : Generic?
    var zip             : Generic?
    var dateModified    : Date?
    var objectId        : NSManagedObjectID?
    
    init() {
        address1        = Generic("")
        address2        = Generic("")
        city            = Generic("")
        state           = Generic("")
        lat             = Generic("")
        long            = Generic("")
        searchText      = Generic("")
        state           = Generic("")
        zip             = Generic("")
        searchType      = SearchType.none
        searchFor       = SearchFor.none
    }
    init(search: NSManagedObject) {
        address1        = Generic(search.value(forKey: "address1") as? String)
        address2        = Generic(search.value(forKey: "address2") as? String)
        city            = Generic(search.value(forKey: "city") as? String)
        lat             = Generic(search.value(forKey: "lat") as? String)
        long            = Generic(search.value(forKey: "long") as? String)
        searchText      = Generic(search.value(forKey: "searchText") as? String)
        searchType      = SearchType(rawValue: (search.value(forKey: "searchType") as? Int ?? 0)) ?? SearchType.none
        searchFor       = SearchFor(rawValue: (search.value(forKey: "searchFor") as? Int ?? 0)) ?? SearchFor.none
        state           = Generic(search.value(forKey: "state") as? String)
        zip             = Generic(search.value(forKey: "zip") as? String)
        dateModified    = search.value(forKey: "dateModified") as? Date
        objectId        = search.objectID
    }
}
