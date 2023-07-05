//
//  DeutscheBankTestTests.swift
//  DeutscheBankTestTests
//
//  Created by Taranjeet Kaur on 04/07/23.
//

import XCTest
import Combine
@testable import DeutscheBankTest

final class DeutscheBankTestTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()

    override func setUp() { }
    
    override func tearDown() {
        cancellables = []
    }

    func testFetchPhotos_Success() async {
        let expectation = XCTestExpectation(description: "Posts are fetched successfully")
        let sut = PostListViewModel(service: MockAPIService())
        await sut.getPosts()
        
        sut.$posts.sink { post in
            if post.count > 0{
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchPhotos_Error() async {
        let expectation = XCTestExpectation(description: "Posts are not fetched successfully")
        let sut = PostListViewModel(service: MockAPIService(isSuccess: false))
        await sut.getPosts()
        
        sut.$posts.sink { post in
            if post.count > 0{
                XCTFail()
            }
        }.store(in: &cancellables)
        
        sut.$errorMessage.sink { errorMsg in
            if !errorMsg.isEmpty {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }

}
