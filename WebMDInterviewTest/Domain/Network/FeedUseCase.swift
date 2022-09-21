//
//  FeedUseCase.swift
//  WebMDInterviewTest
//
//  Created by darindra.khadifa on 08/09/22.
//

import Foundation
import RxSwift

internal struct FeedUseCase {
    internal var fetchItems: () -> Observable<Result<FeedResponseModel, ReaderError>>

    internal init(fetchItems: @escaping () -> Observable<Result<FeedResponseModel, ReaderError>>) {
        self.fetchItems = fetchItems
    }
}

extension FeedUseCase {
    internal static func live() -> Self {
        FeedUseCase(
            fetchItems: _fetchItems
        )
    }
}

private func _fetchItems() -> Observable<Result<FeedResponseModel, ReaderError>> {
    .just(ResourceReader.shared.read(resource: "data", model: FeedResponseModel.self))
}
