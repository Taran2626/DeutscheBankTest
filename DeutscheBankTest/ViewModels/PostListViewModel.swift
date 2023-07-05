//
//  PostListViewModel.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 04/07/23.
//

import Foundation
import SwiftUI

protocol PostListViewProtocol {
    var posts: [Post] { get set }
    var userId: String? { get }
    var isLoading: Bool { get }
    var filteredItems: [Post] { get }
    func getPosts() async
    func sortFavs()
    func contains(_ post: Post) -> Bool
    func toggleFav(post: Post)
}

class PostListViewModel: ObservableObject, PostListViewProtocol {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var showingFavs = false
    @Published var savedItems: Set<Int> = []
    var userId: String?
    var filteredItems: [Post]{
        if showingFavs {
            return posts.filter { savedItems.contains($0.id) }
        }else{
            return posts
        }
    }
    private var db = Database()
    let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }
    
    @MainActor
    func getPosts() async{
        
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            posts = try await service.getJSON(urlString: getUrlString())
            savedItems = db.load(for: userId ?? "")
        }
        catch{
            errorMessage = error.localizedDescription
        }
    }
    
    func sortFavs() {
        withAnimation {
            showingFavs.toggle()
        }
    }
    
    func contains(_ post: Post) -> Bool {
        savedItems.contains(post.id)
    }
    
    func toggleFav(post: Post) {
        if contains(post){
            savedItems.remove(post.id)
        }else{
            savedItems.insert(post.id)
        }
        db.save(posts: savedItems, for: userId ?? "")
    }
    
}

private extension PostListViewModel {

    private func getUrlString() -> String {
        guard let userId = userId else { return "" }
        return "https://jsonplaceholder.typicode.com/users/\(userId)/posts"
    }

}
