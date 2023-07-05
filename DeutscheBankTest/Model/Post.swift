//
//  Post.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 04/07/23.
//

struct Post: Decodable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
 
    init(
        id: Int,
        userId: Int,
        title: String,
        body: String
    ) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
    }
    
    static func initial() -> Post {
        .init(
            id: 1,
            userId: 1,
            title: "Abc Title",
            body: "XYZ Body"
        )
    }
}
