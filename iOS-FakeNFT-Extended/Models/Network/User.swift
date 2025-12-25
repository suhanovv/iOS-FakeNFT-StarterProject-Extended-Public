import Foundation

struct User: Decodable, Identifiable, Hashable {
    let name: String
    let avatarRaw: String?
    let description: String?
    let websiteRaw: String?
    let nfts: [String]
    let likes: [String]
    let rating: Int?
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case avatarRaw = "avatar"
        case description
        case websiteRaw = "website"
        case nfts
        case likes
        case rating
        case id
    }
    
    var website: String {
        websiteRaw ?? ""
    }
    
    var avatar: URL? {
        guard
            let raw = avatarRaw?.trimmingCharacters(in: .whitespacesAndNewlines),
            !raw.isEmpty,
            let url = URL(string: raw)
        else { return nil }
        return url
    }
    
    var websiteURL: URL? {
        guard
            let raw = websiteRaw?.trimmingCharacters(in: .whitespacesAndNewlines),
            !raw.isEmpty,
            let url = URL(string: raw)
        else { return nil }
        return url
    }
}
