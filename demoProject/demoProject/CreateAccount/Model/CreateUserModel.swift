/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct CreateUserResponse : Codable {
	let user : User?

	enum CodingKeys: String, CodingKey {

		case user = "User"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user = try values.decodeIfPresent(User.self, forKey: .user)
	}

}
struct ProfileRolesList : Codable {
    let profileID : String?
    let profilerRoleID : String?
    let firstName : String?
    let lastName : String?
    let profileImageURL : String?

    enum CodingKeys: String, CodingKey {

        case profileID = "ProfileID"
        case profilerRoleID = "ProfilerRoleID"
        case firstName = "FirstName"
        case lastName = "LastName"
        case profileImageURL = "ProfileImageURL"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profileID = try values.decodeIfPresent(String.self, forKey: .profileID)
        profilerRoleID = try values.decodeIfPresent(String.self, forKey: .profilerRoleID)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        profileImageURL = try values.decodeIfPresent(String.self, forKey: .profileImageURL)
    }

}
struct User : Codable {
    let token : String?
    let expiration : String?
    let profileRolesList : [ProfileRolesList]?
    var profile : Profile?

    enum CodingKeys: String, CodingKey {

        case token = "Token"
        case expiration = "Expiration"
        case profileRolesList = "ProfileRolesList"
        case profile            = "Profile"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        expiration = try values.decodeIfPresent(String.self, forKey: .expiration)
        profileRolesList = try values.decodeIfPresent([ProfileRolesList].self, forKey: .profileRolesList)
        profile = try values.decodeIfPresent(Profile.self, forKey: .profile)

    }

}
