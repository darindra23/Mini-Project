import Foundation

internal struct FeedResponseModel: Decodable, Equatable {
    internal let items: [FeedItemModel]
}
