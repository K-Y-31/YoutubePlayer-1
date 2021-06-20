//
//  J_RockVideoData.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/12.
//

import Foundation

struct JlockVideo: Codable {
    public var items: [JlockItems]
}

struct JlockItems: Codable, Identifiable{
    public var id: String
    public var etag: String
    public var snippet: JlockSnippet
}

struct JlockId: Codable {
    public var kind: String
    public var videoId: String
}

struct JlockSnippet: Codable {
    public var publishedAt: String
    public var channelId: String
    public var title: String
    public var description: String
    public var thumbnails: JlockThumbnails
    public var resourceId: JlockResourceId
}

struct JlockHigh: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct JlockMedium: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct JlockStandard: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct JlockMaxres: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct JlockThumbnails: Codable {
    public var medium: JlockMedium?
    public var high: JlockHigh?
    public var standard: JlockStandard?
    public var maxres: JlockMaxres?
}

struct JlockResourceId: Codable {
    public var videoId: String
}
