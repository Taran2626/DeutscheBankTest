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
    
    func testFavPosts() async {
        let expectation = XCTestExpectation(description: "Posts are marked favourites")
        let sut = PostListViewModel(service: MockAPIService(), db: MockDatabase())
        await sut.getPosts()
        
        let firstPost = sut.posts.first ?? Post.initial()
        sut.toggleFav(post: firstPost)
        
        sut.$savedItems.sink { item in
            if item.count > 0 {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testUnFavPosts() async {
        let expectation = XCTestExpectation(description: "Posts are marked unfavourites")
        let sut = PostListViewModel(service: MockAPIService(), db: MockDatabase())
        await sut.getPosts()
        
        let firstPost = sut.posts.first ?? Post.initial()
        sut.toggleFav(post: firstPost)
        if sut.contains(firstPost) {
            sut.toggleFav(post: firstPost)
        }
        sut.$savedItems.sink { item in
            if item.count == 0 {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2)
    }

    func testFilteredItems_All() async{
        let sut = PostListViewModel(service: MockAPIService(), db: MockDatabase())
        await sut.getPosts()
        
        XCTAssertEqual(sut.posts.count, sut.filteredItems.count, "All Posts are shown when all filter is selected")
    }
    
    func testFilteredItems_Fav() async{
        let sut = PostListViewModel(service: MockAPIService(), db: MockDatabase())
        await sut.getPosts()
        
        let firstPost = sut.posts.first ?? Post.initial()
        sut.toggleFav(post: firstPost)
        sut.sortFavs()
        
        XCTAssertEqual(sut.savedItems.count, sut.filteredItems.count, "Fav Posts are shown only when fav filter is selected")
    }

}
