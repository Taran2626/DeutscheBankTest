//
//  CommentsViewModel.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 05/07/23.
//

import Foundation

protocol CommentsViewProtocol {
    var comments: [Comment] { get set }
    var postId: String? { get }
    var isLoading: Bool { get }
    func getComments() async
}

class CommentsViewModel: ObservableObject, CommentsViewProtocol {
    @Published var comments: [Comment] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var showAlert = false
    var postId: String?
       
    @MainActor
    func getComments() async{
        
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            comments = try await APIService().getJSON(urlString: getUrlString())
        }
        catch{
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
}

private extension CommentsViewModel {

    private func getUrlString() -> String {
        guard let postId = postId else { return "" }
        return "https://jsonplaceholder.typicode.com/posts/\(postId)/comments"
    }

}
