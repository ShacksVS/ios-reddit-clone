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
    let authorFullname: String?
    var createdUtc: Double?
    let saved: Bool?
    let domain: String?
    let title: String?
    let thumbnail: String?
    let name: String?
    let ups: Int?
    let downs: Int?
    let numComments: Int?

    static func mock() -> Post {
        return Post(authorFullname: "Fullname", createdUtc: 21,saved: false, domain: "domain", title: "Title", thumbnail: "", name: "t3_name", ups: 9, downs: 2, numComments: 3)
    }
}

func getPostData(subreddit: String, limit: Int, after: String) async -> [Post]? {
    let limitPost = String(limit)
    
    let endPoint = "https://www.reddit.com/\(subreddit)/top.json"
    
    guard var componentUrl = URLComponents(string: endPoint) else {
        print("Invalid URL")
        return nil
    }
    componentUrl.queryItems = [URLQueryItem(name: "limit", value: limitPost), URLQueryItem(name: "after", value: after)]
//    print(componentUrl!)
    
    do {
        let (apiData, _) = try await URLSession.shared.data(from: componentUrl.url!)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let response = try decoder.decode(RedditResponse.self, from: apiData)

        let posts = response.data.children.map { $0.data }
        return posts
        
    } catch {
        print("Error occurred: \(error)")
        return nil
    }
}

