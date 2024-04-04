//
//  Comment.swift
//  CommentsApp
//
//  Created by Viktor Sovyak on 3/19/24.
//

import Foundation

struct RedditCommentResponse: Codable {
    let data: RedditCommentData
}

struct RedditCommentData: Codable {
    let children: [RedditCommentContainer]
}

struct RedditCommentContainer: Codable {
    let data: Comment
}

struct Comment: Codable, Hashable {
    let authorFullname: String?
    let body: String?
    let createdUtc: Double?
    let score: Int?
    let permalink: String?
    
    
    var timeString: String {
        let commentDate = Date(timeIntervalSince1970: createdUtc ?? 0)
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: commentDate, relativeTo: Date())
    }
    
    var url: URL {
        return URL(string: "https://www.reddit.com\(permalink ?? "")")!
    }

    static func mock() -> Comment {
        let text: String = "blah blah blah"

        return Comment(authorFullname: "/u/username", body: text, createdUtc: nil, score: 12, permalink: "https://www.apple.com")
    }
}

func getComments(subreddit: String, postId: String) async -> [Comment]? {
    let endPoint = "https://www.reddit.com/\(subreddit)/comments/\(postId)/.json"
    
    guard let urlRequest = URLComponents(string: endPoint) else {
        print("Invalid URL")
        return nil
    }
    
    do {
        let (apiData, _) = try await URLSession.shared.data(from: urlRequest.url!)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode([RedditCommentResponse].self, from: apiData)
                
        return response[1].data.children.map { $0.data }
    } catch {
        print("Error occurred with getting comments: \(error)")
        return nil
    }
}
