//
//  PostCell.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 05/07/23.
//

import SwiftUI

struct PostCell: View {
    var post: Post
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title.capitalized)
                .font(.headline)
            Text(post.body)
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: Post.initial())
    }
}
