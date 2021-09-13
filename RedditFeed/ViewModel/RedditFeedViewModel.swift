//
//  RedditFeedViewModel.swift
//  RedditFeed
//
//  Created by Erickson Philip Rathina Pandi on 9/10/21.
//

import Foundation
import UIKit
class RedditViewModel {
    var model: [FeedDataChildren]? = nil
    let redditService = NetworkService()
    var shouldLoadMore = false
    
    // Get reddit count
    var redditFeedCount: Int {
        if let feedCount = model?.count {
            return feedCount
        }
        return .zero
    }
    
    // Get next page of Reddit feeds
    var nextFeedPage = ""
        
    //Get list of Reddit feeds
    func getRedditFeeds(isLoadMore: Bool = false,
                        completion: @escaping (Bool) -> ()) {
        var urlString = ""
        if isLoadMore {
            urlString = redditFeedAPI + "?after=" + nextFeedPage
        } else {
            urlString = redditFeedAPI
        }
        
        redditService.get(urlString: urlString) { result in
            switch result {
            case .success(let modal):
                self.nextFeedPage = modal.data.after
                let childrenData = modal.data.children
                if isLoadMore {
                    self.model?.append(contentsOf: childrenData)
                } else {
                    self.model = modal.data.children
                }
                completion(true)
            case .failure(.noData):
                completion(false)
                break
            case .failure(.serverError):
                completion(false)
                break
            case .failure(.dataDecodingError):
                completion(false)
                break
            }
        }
    }
}
