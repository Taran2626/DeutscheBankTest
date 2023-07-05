//
//  Database.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 04/07/23.
//

import Foundation

final class Database {
    private let FAV_KEY = "fav_key"
    
    func save(posts: Set<Int>, for userId: String){
        var dict = UserDefaults.standard.dictionary(forKey: FAV_KEY) as? [String: [Int]] ?? [String: [Int]]()
        dict[userId] = Array(posts)
        UserDefaults.standard.set(dict, forKey: FAV_KEY)
    }
    
    func load(for userId: String) -> Set<Int> {
        let dict = UserDefaults.standard.dictionary(forKey: FAV_KEY) as? [String: [Int]] ?? [String: [Int]]()
        let array = dict[userId] ?? [Int]()
        return Set(array)
    }
    
}
