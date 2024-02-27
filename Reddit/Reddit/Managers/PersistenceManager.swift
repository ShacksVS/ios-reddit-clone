//
//  PersistenceManager.swift
//  Reddit
//
//  Created by Viktor Sovyak on 2/26/24.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let savedPostsFile = URL.documentsDirectory.appending(path: "savedPosts.json")
    
    private init() {}
    
    // MARK: change the state of the particular post
    func togglePostSave(_ post: Post) {
        var savedPosts = getPosts()
        
        if savedPosts.contains(post) {
            savedPosts.removeAll(where: { post.name == $0.name })
        } else {
            savedPosts.append(post)
        }
        
        print(savedPosts.count)
        guard let encodedPosts = try? JSONEncoder().encode(savedPosts) else { return }
        try? encodedPosts.write(to: savedPostsFile, options: .atomic)
    }
    
    // MARK: get encoded saved posts
    func getPosts() -> [Post] {
        guard
            FileManager.default.fileExists(atPath: savedPostsFile.path()),
            let postsData = FileManager.default.contents(atPath: savedPostsFile.path())
        else {
            return []
        }
        return (try? JSONDecoder().decode([Post].self, from: postsData)) ?? []
    }
}
