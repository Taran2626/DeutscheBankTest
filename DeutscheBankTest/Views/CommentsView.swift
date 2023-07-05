//
//  CommentsView.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 05/07/23.
//

import SwiftUI

struct CommentsView: View {
    @StateObject var vmPost = PostListViewModel()
    @StateObject var vmComment = CommentsViewModel()
    var post : Post
    
    var body: some View {
        VStack {
            PostRowView(vm: vmPost, post: post)
            List {
                ForEach(vmComment.comments) { comment in
                    CommentCell(comment: comment)
                }
            }}
            .overlay(content: {
                if vmComment.isLoading {
                    ProgressView()
                }
            })
            .alert("Application Error", isPresented: $vmComment.showAlert, actions: {
                Button("OK") {}
            }, message: {
                if let errorMessage = vmComment.errorMessage {
                    Text(errorMessage)
                }
            })
            .listStyle(.plain)
            .task {
                vmComment.postId = String(post.id)
                await vmComment.getComments()
            }
        .padding()
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(post: Post.initial())
    }
}
