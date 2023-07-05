//
//  Comment.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 05/07/23.
//

struct Comment: Decodable, Identifiable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
 
    init(
        postId: Int,
        id: Int,
        name: String,
        email: String,
        body: String
    ) {
        self.postId = postId
        self.id = id
        self.name = name
        self.email = email
        self.body = body
    }
    
    static func initial() -> Comment {
        .init(
            postId: 1,
            id: 1,
            name: "ABC",
            email: "Abc@gmail.com",
            body: "XYZ Body"
        )
    }
}
