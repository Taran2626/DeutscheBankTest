//
//  MockAPIService.swift
//  DeutscheBankTestTests
//
//  Created by Taranjeet Kaur on 05/07/23.
//

import Foundation
@testable import DeutscheBankTest

struct MockAPIService : APIServiceProtocol {
    
    var isSuccess = true
    
    init(isSuccess : Bool = true){
        self.isSuccess = isSuccess
    }
    
    func getJSON<T>(urlString: String) async throws -> T where T : Decodable {
        let decodedData = Bundle.main.decode(T.self, from: "Post.json")
        if isSuccess {
            return decodedData
        } else {
            throw APIError.corruptData
        }
    }
    
}
