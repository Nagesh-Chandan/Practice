//
//  UnfurlURLOperation.swift
//  PracticeApp
//
//  Created by Nagesh Chandan on 08/09/23.
//

import Foundation

final class UnfurlURLOperation: AsyncResultOperation<URL, UnfurlURLOperation.Error> {
    enum Error: Swift.Error {
        case canceled
        case missingRedirectURL
        case underlying(error: Swift.Error)
    }

    private let shortURL: URL
    private var dataTask: URLSessionTask?

    init(shortURL: URL) {
        self.shortURL = shortURL
    }

    override func main() {
        var request = URLRequest(url: shortURL)
        request.httpMethod = "HEAD"

        dataTask = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (_, response, error) in
            if let error = error {
                self?.finish(with: .failure(Error.underlying(error: error)))
                return
            }

            guard let longURL = response?.url else {
                self?.finish(with: .failure(Error.missingRedirectURL))
                return
            }

            self?.finish(with: .success(longURL))
        })
        dataTask?.resume()
    }

    override func cancel() {
        dataTask?.cancel()
        cancel(with: .canceled)
    }
}
