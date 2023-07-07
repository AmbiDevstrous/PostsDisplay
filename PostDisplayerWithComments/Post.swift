//
//  Post.swift
//  PostDisplayerWithComments
//
//  Created by Macbook on 7/07/23.
//

import Foundation


struct Post:Decodable {
    
    let userId :Int
    let id : String
    let title: String
    let body: String
}


final class GetPostsService {
    //gets the credit card data from the hardcoded API using URLRequest.
    enum ServiceError: Error, LocalizedError {
        case cannotCreateURL
        case urlSessionDidFail
        case cannotDecodeData
        
        var localizedDescription: String {
            switch self {
            case .cannotCreateURL:
                return "Cannot Create URL" // bad url
            case .urlSessionDidFail:
                return "URL Session Failed" //url failed on get.
            case .cannotDecodeData:
                return "Cannot Decode Data" //model did not match json properties.
            }
        }
    }
    
    private let urlString = "https://jsonplaceholder.typicode.com"
    private let jsonDecoder = JSONDecoder()
    private(set) var posts: [Post]?
    private(set) var localizedDescription: String?

    func fetch() {
                
        Task {
            do {
                posts = try await self.fetchPosts()
            } catch {
                localizedDescription = error.localizedDescription
            }
        }
    }
    
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: urlString) else {
            throw ServiceError.cannotCreateURL
        }
        
        let request = URLRequest(url: url)
        let data: Data
        
        do {
            data = try await URLSession.shared.data(for: request).0
            let blah = "seferfe "
            let gah = "wefwef"
            let sdf = blah + gah
        } catch {
            throw ServiceError.urlSessionDidFail
        }
        

        
        do {
            posts = try jsonDecoder.decode([Post].self, from: data)
        } catch {
            throw ServiceError.cannotDecodeData
        }
        
        return posts!
    }
}

