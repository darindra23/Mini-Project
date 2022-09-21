import Foundation
import RxCocoa
import RxSwift

internal struct FeedViewModel {
    // - MARK: Environment
    private let useCase = FeedUseCase.live()

    // - MARK: Observable
    internal struct Input {
        internal let didLoad: Observable<Void>
    }

    internal struct Output {
        internal let items: Driver<[FeedItemModel]>
    }

    internal func transform(input: Input) -> Output {
        let response = input.didLoad
            .flatMap { [useCase] _ in
                useCase.fetchItems()
            }

        let successResponse = response
            .compactMap(\.success)

        let uniqueItem = successResponse
            .map { Array(Set($0.items)) }

        let sortedItem = uniqueItem
            .map { $0.sorted { $0.title < $1.title } }
            .asDriver(onErrorJustReturn: [])

        return Output(items: sortedItem)
    }
}
