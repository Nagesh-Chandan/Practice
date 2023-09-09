//
//  CompletionOperation.swift
//  PracticeApp
//
//  Created by Nagesh Chandan on 08/09/23.
//

import Foundation

/// A closure provides touple of something.
public typealias Callback<T> = (T) -> Void

/// A closure provides nothing.
public typealias CompletionHandler = () -> Void

final class CompletionOperation: AsyncOperation {
    
    private let callback: Callback<CompletionHandler>
    
    /// The asyncronous operation that allow developer to mark operation as completed without inheriting the `AsyncOperation`
    /// - Parameter callback: The task that will be executed by the operation. The callback's argument is a closure function for marking operation as completed.
    init(_ callback: @escaping Callback<CompletionHandler>) {
        self.callback = callback
    }
    
    override func main() {
        callback { [weak self] in self?.finish() }
    }
}
