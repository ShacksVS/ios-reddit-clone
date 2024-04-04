//
//  CommentCell.swift
//  CommentsApp
//
//  Created by Viktor Sovyak on 3/18/24.
//

import SwiftUI

extension CommentCell {
    @ViewBuilder func userInfo() -> some View {
        HStack {
            Image(systemName: "person.circle")
            Text(comment?.authorFullname ?? "user")
                .font(.subheadline)
                .foregroundStyle(.gray)

            
            Text("• \(comment?.timeString ?? "0")")
                .font(.subheadline)
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder func commentText() -> some View {
        Text(comment?.body ?? "No comment text")
            .padding(.vertical, 10)
            .multilineTextAlignment(.leading)
            .foregroundColor(.primary)
    }
    
    @ViewBuilder func ratingButton() -> some View {
        Button(action: {
            print("Image tapped!")
        }) {
            Text("Rating : \(comment?.score ?? 0)")
                .font(.subheadline)
                .foregroundColor(Color(.systemBlue))
        }
    }
}

struct CommentCell: View {
    var comment: Comment?
    
    var body: some View {
        VStack(alignment: .leading) {
            userInfo()
            commentText()
            ratingButton()
        }
//        .border(Color.gray, width: 1)
        .foregroundColor(.secondary)
        .padding(.horizontal)
        Divider()

    }
}

#Preview {
    CommentCell(comment: Comment.mock())
}
