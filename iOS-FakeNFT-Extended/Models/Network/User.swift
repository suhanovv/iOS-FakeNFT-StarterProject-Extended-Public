import Foundation

struct User: Decodable, Identifiable {
    let name: String
    let avatar: URL?
    let description: String?
    let website: URL?
    let nfts: [String]
    @StringToInt
    var rating: Int
    let id: String
}

extension User {
    init(profile: Profile) {
        self.name = profile.name
        self.avatar = profile.avatar
        self.description = profile.description
        self.website = profile.website
        self.nfts = profile.nfts
        self._rating = StringToInt(wrappedValue: 0)
        self.id = profile.id
    }
}
