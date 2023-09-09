//
//  AsyncResultOperation.swift
//  PracticeApp
//
//  Created by Nagesh Chandan on 08/09/23.
//

import Foundation

class AsyncResultOperation<Success, Failure>: AsyncOperation where Failure: Error {

    private(set) public var result: Result<Success, Failure>?

    final override public func finish() {
        guard !isCancelled else { return super.finish() }
        fatalError("Make use of finish(with:) instead to ensure a result")
    }

    public func finish(with result: Result<Success, Failure>) {
        self.result = result
        super.finish()
    }

    override open func cancel() {
        fatalError("Make use of cancel(with:) instead to ensure a result")
    }

    public func cancel(with error: Failure) {
        self.result = .failure(error)
        super.cancel()
    }
}
