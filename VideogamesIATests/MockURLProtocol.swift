//
//  MockURLProtocol.swift
//  VideogamesIATests
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    
    static var responseData: Data?
    static var responseStatusCode: Int = 200

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let client = client, let responseData = MockURLProtocol.responseData {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: MockURLProtocol.responseStatusCode,
                httpVersion: nil,
                headerFields: nil
            )
            client.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
            client.urlProtocol(self, didLoad: responseData)
        } else {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: MockURLProtocol.responseStatusCode,
                httpVersion: nil,
                headerFields: nil
            )
            client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: Data())
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
