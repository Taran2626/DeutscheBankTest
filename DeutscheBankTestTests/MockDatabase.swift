//
//  MockDatabase.swift
//  DeutscheBankTestTests
//
//  Created by Taranjeet Kaur on 05/07/23.
//

import Foundation
@testable import DeutscheBankTest

class MockDatabase : DatabaseProtocol {
    
    var dict = [String: [Int]]()
    
    func save(posts: Set<Int>, for userId: String) {
        dict[userId] = Array(posts)
    }
    
    func load(for userId: String) -> Set<Int> {
        let array = dict[userId] ?? [Int]()
        return Set(array)
    }
    
}

