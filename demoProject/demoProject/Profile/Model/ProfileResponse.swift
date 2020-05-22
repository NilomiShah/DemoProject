
import Foundation
struct ProfileResponse : Codable {
	var profile : Profile?

	enum CodingKeys: String, CodingKey {

		case profile = "Profile"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		profile = try values.decodeIfPresent(Profile.self, forKey: .profile)
	}

}
struct Profile : Codable {
    var profileID : Generic?
    var profilePhotoURL : Generic?
    var firstName : Generic?
    var lastName : Generic?
    var company : Generic?
    var fullAddress : Generic?
    var address1 : Generic?
    var address2 : Generic?
    var city : Generic?
    var state : Generic?
    var zip : Generic?
    var latitude : Generic?
    var longitude : Generic?
    var bio : Generic?
    var userRole : Generic?
    var jobTitle : Generic?
    var isInstagramLinked: Generic?
    var isYoutubeAccountLinked: Generic?
    var youtubeChannelID: Generic?
//    var serviceList: [Service]?
//    var userProfileJobDetails: UserProfileJobDetails?
    var userID: Generic?
    var youtubeProfileURL: Generic?
    var instagramProfileURL: Generic?
    var allowPushNotification : Generic?
    var hasStripeConnectAccount: Generic?
    
    var profileNameToDisplay: String {
        return (self.firstName?.stringValue ?? "") + " " + (self.lastName?.stringValue ?? "")
    }
    enum CodingKeys: String, CodingKey {
        
        case profileID = "ProfileID"
        case profilePhotoURL = "ProfilePhotoURL"
        case firstName = "FirstName"
        case lastName = "LastName"
        case company = "Company"
        case fullAddress = "FullAddress"
        case address1 = "Address1"
        case address2 = "Address2"
        case city = "City"
        case state = "State"
        case zip = "Zip"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case bio = "Bio"
        case userRole = "UserRole"
        case jobTitle = "JobTitle"
        case isInstagramLinked = "IsInstagramLinked"
        case isYoutubeAccountLinked = "IsYoutubeAccountLinked"
        case serviceList = "ServiceList"
        case userProfileJobDetails = "UserProfileJobDetails"
        case youtubeChannelID = "YoutubeChannelID"
        case userID = "UserID"
        case youtubeProfileURL = "YoutubeProfileURL"
        case instagramProfileURL = "InstagramProfileURL"
        case allowPushNotification = "AllowPushNotification"
        case hasStripeConnectAccount = "HasStripeConnectAccount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profileID = try values.decodeIfPresent(Generic.self, forKey: .profileID) ?? "0"
        profilePhotoURL = try values.decodeIfPresent(Generic.self, forKey: .profilePhotoURL)
        firstName = try values.decodeIfPresent(Generic.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(Generic.self, forKey: .lastName)
        company = try values.decodeIfPresent(Generic.self, forKey: .company)
        fullAddress = try values.decodeIfPresent(Generic.self, forKey: .fullAddress)
        address1 = try values.decodeIfPresent(Generic.self, forKey: .address1)
        address2 = try values.decodeIfPresent(Generic.self, forKey: .address2)
        city = try values.decodeIfPresent(Generic.self, forKey: .city)
        state = try values.decodeIfPresent(Generic.self, forKey: .state)
        zip = try values.decodeIfPresent(Generic.self, forKey: .zip)
        latitude = try values.decodeIfPresent(Generic.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(Generic.self, forKey: .longitude)
        bio = try values.decodeIfPresent(Generic.self, forKey: .bio)
        userRole = try values.decodeIfPresent(Generic.self, forKey: .userRole)
        jobTitle = try values.decodeIfPresent(Generic.self, forKey: .jobTitle)
        isInstagramLinked = try values.decodeIfPresent(Generic.self, forKey: .isInstagramLinked)
        isYoutubeAccountLinked = try values.decodeIfPresent(Generic.self, forKey: .isYoutubeAccountLinked)
//        serviceList = try values.decodeIfPresent([Service].self, forKey: .serviceList)
//        userProfileJobDetails = try values.decodeIfPresent(UserProfileJobDetails.self, forKey: .userProfileJobDetails)
        youtubeChannelID = try values.decodeIfPresent(Generic.self, forKey: .youtubeChannelID)
        userID = try values.decodeIfPresent(Generic.self, forKey: .userID)
        youtubeProfileURL = try values.decodeIfPresent(Generic.self, forKey: .youtubeProfileURL)
        instagramProfileURL = try values.decodeIfPresent(Generic.self, forKey: .instagramProfileURL)
        allowPushNotification = try values.decodeIfPresent(Generic.self, forKey: .allowPushNotification)
        hasStripeConnectAccount = try values.decodeIfPresent(Generic.self, forKey: .hasStripeConnectAccount)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy : CodingKeys.self)
        try container.encode(profileID, forKey: .profileID)
        try container.encode(profilePhotoURL, forKey: .profilePhotoURL)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(company, forKey: .company)
        try container.encode(fullAddress, forKey: .fullAddress)
        try container.encode(address1, forKey: .address1)
        try container.encode(address2, forKey: .address2)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
        try container.encode(zip, forKey: .zip)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(bio, forKey: .bio)
        try container.encode(userRole, forKey: .userRole)
        try container.encode(jobTitle, forKey: .jobTitle)
        try container.encode(isInstagramLinked, forKey: .isInstagramLinked)
        try container.encode(isYoutubeAccountLinked, forKey: .isYoutubeAccountLinked)
//        try container.encode(serviceList, forKey: .serviceList)
//        try container.encode(userProfileJobDetails, forKey: .userProfileJobDetails)
        try container.encode(youtubeChannelID, forKey: .youtubeChannelID)
        try container.encode(userID, forKey: .userID)
        try container.encode(youtubeProfileURL, forKey: .youtubeProfileURL)
        try container.encode(instagramProfileURL, forKey: .instagramProfileURL)
        try container.encode(allowPushNotification, forKey: .allowPushNotification)
        try container.encode(hasStripeConnectAccount, forKey: .hasStripeConnectAccount)
    }
}
