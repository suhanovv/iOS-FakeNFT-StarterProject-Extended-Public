import Foundation

import Foundation

struct Profile: Decodable, Hashable {
    let name: String
    let avatar: URL?
    let description: String?
    let website: URL?
    let nfts: [String]
    let likes: [String]
    let id: String

    enum CodingKeys: String, CodingKey {
        case name
        case avatar
        case description
        case website
        case nfts
        case likes
        case id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        nfts = try container.decode([String].self, forKey: .nfts)
        likes = try container.decode([String].self, forKey: .likes)
        id = try container.decode(String.self, forKey: .id)

        let descriptionString = try container.decodeIfPresent(String.self, forKey: .description)
        description = descriptionString?.isEmpty == true ? nil : descriptionString

        let avatarString = try container.decodeIfPresent(String.self, forKey: .avatar)
        avatar = avatarString.flatMap { $0.isEmpty ? nil : URL(string: $0) }

        let websiteString = try container.decodeIfPresent(String.self, forKey: .website)
        website = websiteString.flatMap { $0.isEmpty ? nil : URL(string: $0) }
    }
}
