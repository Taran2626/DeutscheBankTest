//
//  PostRowView.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 05/07/23.
//

import SwiftUI

struct PostRowView: View {
    @StateObject var vm = PostListViewModel()
    var post : Post
    
    var body: some View {
        HStack(alignment: .top){
            PostCell(post: post)
            Spacer()
            Image(systemName: vm.contains(post) ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .padding(.top, 4.0)
                .onTapGesture {
                    vm.toggleFav(post: post)
                }
        }
    }
}

struct PostRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(post: Post.initial())
    }
}
