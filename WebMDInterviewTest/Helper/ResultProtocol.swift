//
//  ResultProtocol.swift
//  WebMDInterviewTest
//
//  Created by darindra.khadifa on 09/09/22.
//

import Foundation

public protocol ResultProtocol {
    associatedtype Success
    associatedtype Failure: Error

    init(success: Success)
    init(failure: Failure)

    func analysis<U>(ifSuccess: (Success) -> U, ifFailure: (Failure) -> U) -> U

    var success: Success? { get }
    var failure: Failure? { get }
}

extension ResultProtocol {
    public var success: Success? {
        return analysis(ifSuccess: { $0 }, ifFailure: { _ in nil })
    }

    public var failure: Failure? {
        return analysis(ifSuccess: { _ in nil }, ifFailure: { $0 })
    }
}

extension Result: ResultProtocol {
    public init(success: Success) {
        self = .success(success)
    }

    public init(failure: Failure) {
        self = .failure(failure)
    }

    public func analysis<Result>(ifSuccess: (Success) -> Result, ifFailure: (Failure) -> Result) -> Result {
        switch self {
        case let .success(value):
            return ifSuccess(value)
        case let .failure(value):
            return ifFailure(value)
        }
    }
}
