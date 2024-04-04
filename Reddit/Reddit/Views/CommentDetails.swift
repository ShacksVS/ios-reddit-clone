//
//  CommentDetails.swift
//  CommentsApp
//
//  Created by Viktor Sovyak on 3/18/24.
//

import SwiftUI

extension CommentDetails {
    @ViewBuilder func userInfo() -> some View {
        HStack {
            Text(comment?.authorFullname ?? "user")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                    
            Text("• \(comment?.timeString ?? "0")")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    @ViewBuilder func commentText() -> some View {
        Text(comment?.body ?? "No comment text")
            .padding(.vertical, 5)
    }
    
    @ViewBuilder func ratingView() -> some View {
        Button(action: {
            print("Image tapped!")
        }) {
            Label("Rating: \(comment?.score ?? 0)", systemImage: "arrow.up.circle.fill")
                .font(.subheadline)
                .foregroundColor(Color(.systemBlue))
                .padding(.vertical, 5)
        }
    }
    
    @ViewBuilder func shareLink() -> some View {
        ShareLink(item: comment?.url ?? URL(string: "https://www.apple.com")!) {
            Label("Share", systemImage: "square.and.arrow.up")
                .font(.subheadline)
                .frame(maxWidth: .infinity)
                .padding(7)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct CommentDetails: View {
    var comment: Comment?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                userInfo()
                commentText()
                ratingView()
                shareLink()
            }
            .padding()
            .frame(minWidth: 200, maxWidth: 350)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 0.5)
        )
    }
}


#Preview {
    CommentDetails(comment: Comment.mock())
}
