

import Foundation
struct MasterResponse : Codable {
	let googleAPIKey : String?
	let googleAuthKey : String?
	let instagramAppID : String?
	let avatarList : [AvatarList]?
	let serviceCategoryList : [ServiceCategoryList]?

	enum CodingKeys: String, CodingKey {

		case googleAPIKey = "GoogleAPIKey"
		case googleAuthKey = "GoogleAuthKey"
		case instagramAppID = "InstagramAppID"
		case avatarList = "AvatarList"
		case serviceCategoryList = "ServiceCategoryList"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		googleAPIKey = try values.decodeIfPresent(String.self, forKey: .googleAPIKey)
		googleAuthKey = try values.decodeIfPresent(String.self, forKey: .googleAuthKey)
		instagramAppID = try values.decodeIfPresent(String.self, forKey: .instagramAppID)
		avatarList = try values.decodeIfPresent([AvatarList].self, forKey: .avatarList)
		serviceCategoryList = try values.decodeIfPresent([ServiceCategoryList].self, forKey: .serviceCategoryList)
	}

}
struct ServiceCategoryList : Codable {
    let iD : String?
    let name : String?
    let description : String?
    let imageURL : String?
    let hexColor : String?
    let sortOrder : String?
    let coverImageURL : String?
    let serviceSubCategoryDetailsList : [ServiceSubCategoryDetailsList]?

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case name = "Name"
        case description = "Description"
        case imageURL = "ImageURL"
        case hexColor = "HexColor"
        case sortOrder = "SortOrder"
        case coverImageURL = "CoverImageURL"
        case serviceSubCategoryDetailsList = "ServiceSubCategoryDetailsList"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        hexColor = try values.decodeIfPresent(String.self, forKey: .hexColor)
        sortOrder = try values.decodeIfPresent(String.self, forKey: .sortOrder)
        coverImageURL = try values.decodeIfPresent(String.self, forKey: .coverImageURL)
        serviceSubCategoryDetailsList = try values.decodeIfPresent([ServiceSubCategoryDetailsList].self, forKey: .serviceSubCategoryDetailsList)
    }

}
struct AvatarList : Codable {
    let iD : String?
    let imageURL : String?
    let sortOrder : String?

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case imageURL = "ImageURL"
        case sortOrder = "SortOrder"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        sortOrder = try values.decodeIfPresent(String.self, forKey: .sortOrder)
    }

}
struct ServiceSubCategoryDetailsList : Codable {
    let iD : String?
    let name : String?
    let description : String?
    let imageURL : String?
    let sortOrder : String?
    let serviceCategoryID : String?

    enum CodingKeys: String, CodingKey {

        case iD = "ID"
        case name = "Name"
        case description = "Description"
        case imageURL = "ImageURL"
        case sortOrder = "SortOrder"
        case serviceCategoryID = "ServiceCategoryID"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iD = try values.decodeIfPresent(String.self, forKey: .iD)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
        sortOrder = try values.decodeIfPresent(String.self, forKey: .sortOrder)
        serviceCategoryID = try values.decodeIfPresent(String.self, forKey: .serviceCategoryID)
    }

}
