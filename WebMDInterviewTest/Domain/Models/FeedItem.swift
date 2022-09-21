import Foundation

internal struct FeedItemModel: Decodable, Hashable, Equatable {
    internal let title: String
    internal let description: String
    internal let imageURL: URL?
    internal let detail: String

    private enum CodingKeys: String, CodingKey {
        case title, description, detail
        case imageURL = "image_url"
    }

    internal init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        title = try values.decode(String.self, forKey: .title)
        description = try values.decode(String.self, forKey: .description)
        imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL).flatMap(URL.init)
        detail = try values.decode(String.self, forKey: .detail)
    }

    internal init(
        title: String,
        description: String,
        imageURL: String,
        detail: String
    ) {
        self.title = title
        self.description = description
        self.imageURL = URL(string: imageURL)
        self.detail = detail
    }
}
