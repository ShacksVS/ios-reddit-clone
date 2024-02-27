//
//  PostManager.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/24/24.
//

import Foundation

class PostManager {
    static let shared = PostManager()
    private init() {}

    var posts: [Post] = []

    func toggleSavedState(for post: Post) {
        guard let index = posts.firstIndex(where: { $0.name == post.name }) else { return }
        posts[index].toggleFavorite()
        
        // Notify observers about the change
        NotificationCenter.default.post(name: .postSavedStateChanged, object: nil, userInfo: ["post": posts[index]])
    }
    
    // Function to update the entire post, useful when coming from details view
    func updatePost(_ updatedPost: Post) {
        guard let index = posts.firstIndex(where: { $0.name == updatedPost.name }) else { return }
        posts[index] = updatedPost
        
        // Notify observers about the change
        NotificationCenter.default.post(name: .postUpdated, object: nil, userInfo: ["post": updatedPost])
    }
}

extension Notification.Name {
    static let postSavedStateChanged = Notification.Name("postSavedStateChanged")
    static let postUpdated = Notification.Name("postUpdated")
}
