//
//  URLSessionHTTPClientTests.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import XCTest
import Combine
@testable import CleanArchitecture

final class URLSessionHTTPClientTests: XCTestCase {
    private var sut: URLSessionHTTPClient!
    private var sessionMock: URLSessionMock!
    private var cancellables: Set<AnyCancellable>!
    private var errorResolver: URLSessionErrorResolver!

    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        errorResolver = URLSessionErrorResolver()
        sut = URLSessionHTTPClient(session: sessionMock, errorResolver: errorResolver)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        sessionMock = nil
        cancellables = nil
        super.tearDown()
    }

    func testMakeRequestSuccess() {
        // Arrange
        let url = "https://example.com/data"
        let mockData = "Success Response".data(using: .utf8)!
        sessionMock.mockData = mockData
        sessionMock.mockResponse = HTTPURLResponse(url: URL(string: url)!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let expectation = XCTestExpectation(description: "Request should succeed")

        // Act
        sut.makeRequest(endpoint: url)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { data in
                // Assert
                XCTAssertEqual(data, mockData)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testMakeRequestClientError() {
        // Arrange
        let invalidURL = "invalid-url"
        let expectation = XCTestExpectation(description: "Request should fail due to invalid URL")

        // Act
        sut.makeRequest(endpoint: invalidURL)
            .sink(receiveCompletion: { completion in
                // Assert
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testMakeRequestServerError() {
        // Arrange
        let url = "https://example.com/data"
        sessionMock.mockResponse = HTTPURLResponse(url: URL(string: url)!, statusCode: 500, httpVersion: nil, headerFields: nil)
        let expectation = XCTestExpectation(description: "Request should fail due to server error")

        // Act
        sut.makeRequest(endpoint: url)
            .sink(receiveCompletion: { completion in
                // Assert
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMemoryLeaks() {
        // Act
        weak var weakSUT = sut
        sut = nil
        
        // Assert
        XCTAssertNil(weakSUT, "The URLSessionHTTPClient instance was not deallocated, indicating a memory leak.")
    }
}
