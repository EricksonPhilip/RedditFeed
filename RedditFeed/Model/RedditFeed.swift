//
//  RedditFeed.swift
//  RedditFeed
//
//  Created by Erickson Philip Rathina Pandi on 9/10/21.
//

import Foundation
// Model for Reddit feeds
struct RedditFeed: Codable {
    let kind: String
    let data: FeedData
    
    enum CodingKeys: String, CodingKey {
        case kind = "kind"
        case data = "data"
    }
}

struct FeedData: Codable {
    let after: String
    let dist: Int
    let children: [FeedDataChildren]
}

struct FeedDataChildren: Codable {
    let data: FeedDataChildrenData
}

struct FeedDataChildrenData: Codable {
    let title: String
    let subRedditPrefix: String
    let postHint: String
    let ups: Int
    let downs: Int
    let thumbnail: String
    let thumbnailWidth: Float
    let thumbnailHieght: Float
    let viewCount: String
    let comments: Int
    let score: Int
    let imageOrLink: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case subRedditPrefix = "subreddit_name_prefixed"
        case postHint = "post_hint"
        case ups = "ups"
        case downs = "downs"
        case thumbnail = "thumbnail"
        case thumbnailWidth = "thumbnail_width"
        case thumbnailHieght = "thumbnail_height"
        case viewCount = "view_count"
        case comments = "num_comments"
        case score = "score"
        case imageOrLink = "url_overridden_by_dest"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title  = try values.decode(String.self, forKey: .title)
        self.subRedditPrefix = try values.decode(String.self, forKey: .subRedditPrefix)
        self.ups = try values.decode(Int.self, forKey: .ups)
        self.downs = try values.decode(Int.self, forKey: .downs)
        self.score = try values.decode(Int.self, forKey: .score)
        self.comments = try values.decode(Int.self, forKey: .comments)
        
        if values.contains(.thumbnail) {
            if let decodeValue = try values.decodeIfPresent(String.self,
                                                            forKey: .thumbnail) {
                self.thumbnail = decodeValue
            } else {
                self.thumbnail = ""
            }
        } else {
            self.thumbnail = ""
        }
        
        if values.contains(.thumbnailWidth) {
            if let decodeValue = try values.decodeIfPresent(Float.self,
                                                       forKey: .thumbnailWidth)  {
                self.thumbnailWidth = decodeValue
            } else {
                self.thumbnailWidth = 0.0
            }
        } else {
            self.thumbnailWidth = 0.0
        }
        
        if values.contains(.thumbnailHieght) {
            if let decodeValue = try values.decodeIfPresent(Float.self,
                                                            forKey: .thumbnailHieght) {
                self.thumbnailHieght = decodeValue
            } else {
                self.thumbnailHieght = 0.0
            }
            
        } else {
            self.thumbnailHieght = 0.0
        }
        
        if values.contains(.postHint) {
            self.postHint = try values.decodeIfPresent(String.self,
                                                       forKey: .postHint)!
        } else {
            self.postHint = ""
        }
        
        if values.contains(.viewCount) {
            if let decodeValue = try values.decodeIfPresent(String.self,
                                                            forKey: .viewCount) {
                self.viewCount = decodeValue
            } else {
                self.viewCount = ""
            }
            
        } else {
            self.viewCount = ""
        }
        
        if values.contains(.imageOrLink) {
            self.imageOrLink = try values.decodeIfPresent(String.self,
                                                       forKey: .imageOrLink)!
        } else {
            self.imageOrLink = ""
        }
    }
}
