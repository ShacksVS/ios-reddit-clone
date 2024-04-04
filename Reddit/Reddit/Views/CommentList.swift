//
//  CommentList.swift
//  CommentsApp
//
//  Created by Viktor Sovyak on 3/20/24.
//

import SwiftUI

struct CommentList: View {
    @State private var comments: [Comment] = []
    let subreddit: String
    let postId: String
    let onClick: (Comment) -> Void
    
    var body: some View {
        // change to Contructor with OnTapGesture
        ScrollView {
            Divider()
            LazyVStack (alignment: .leading, spacing: 10) {
                ForEach(comments, id: \.self) { comment in
                    CommentCell(comment: comment)
                        .onTapGesture {
                            onClick(comment)
                        }
                }
            }
        }
        .task {
            comments = await getComments(subreddit: subreddit, postId: postId) ?? []
        }
//        NavigationStack {
//            List(comments, id: \.self) { comment in
//                NavigationLink(value: comment) {
//                    CommentCell(comment: comment)
//                }
//            }
//            .navigationDestination(for: Comment.self) { comment in
//                CommentDetails(comment: comment)
//            }
//            .task {
//                comments = await getComments(subreddit: subreddit, postId: postId) ?? []
//            }
//        }
    }
}

#Preview {
    CommentList(subreddit: "r/ios", postId: "1biv7x9", onClick: { _ in })
}
