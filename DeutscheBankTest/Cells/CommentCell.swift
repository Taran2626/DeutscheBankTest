//
//  CommentCell.swift
//  DeutscheBankTest
//
//  Created by Taranjeet Kaur on 05/07/23.
//

import SwiftUI

struct CommentCell: View {
    var comment: Comment
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(comment.name.capitalized)
                .font(.headline)
            Text(comment.body)
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(comment: Comment.initial())
    }
}
