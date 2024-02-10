import Foundation

struct RedditResponse: Codable {
    let data: RedditData
}

struct RedditData: Codable {
    let children: [RedditPostContainer]
}

struct RedditPostContainer: Codable {
    let data: Post
}

struct Post: Codable {
    let author_fullname: String?
    var subreddit: String?
    let saved: Bool?
    let domain: String?
    let title: String?
    let thumbnail: String?
    let ups: Int?
    let downs: Int?
    let num_comments: Int?
}

func getPostData(limit: Int) async -> Post? {
    let limitPost = String(limit)
    let endPoint = "https://www.reddit.com/r/ios/top.json?limit=\(limitPost)"
    
    guard let url = URL(string: endPoint) else {
        print("Invalid URL")
        return nil
    }
    
//    let component = URLComponents(url: url, resolvingAgainstBaseURL: true)
    
    do {
        let (apiData, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(RedditResponse.self, from: apiData)
        return Post(author_fullname: response.data.children.first?.data.author_fullname,
                    subreddit: response.data.children.first?.data.subreddit,
                    saved: response.data.children.first?.data.saved,
                    domain: response.data.children.first?.data.domain,
                    title: response.data.children.first?.data.title,
                    thumbnail: response.data.children.first?.data.thumbnail,
                    ups: response.data.children.first?.data.ups,
                    downs: response.data.children.first?.data.downs,
                    num_comments: response.data.children.first?.data.num_comments)
    } catch {
        print("Error occurred: \(error)")
        return nil
    }
}

