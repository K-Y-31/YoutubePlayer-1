//
//  ArtistVideoData.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/08.
//

import Foundation

struct FavoriteArtistVideo: Codable {
    public var items: [FavoriteArtistItems]
}

struct FavoriteArtistItems: Codable, Identifiable{
    public var id: String
    public var etag: String
    public var snippet: FavoriteArtistSnippet
}

struct FavoriteArtistId: Codable {
    public var kind: String
    public var videoId: String
}

struct FavoriteArtistSnippet: Codable {
    public var publishedAt: String
    public var channelId: String
    public var title: String
    public var description: String
    public var thumbnails: FavoriteArtistThumbnails
    public var resourceId: FavoriteArtistResourceId
}

struct FavoriteArtistHigh: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct FavoriteArtistMedium: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct FavoriteArtistStandard: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct FavoriteArtistMaxres: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct FavoriteArtistThumbnails: Codable {
    public var medium: FavoriteArtistMedium?
    public var high: FavoriteArtistHigh?
    public var standard: FavoriteArtistStandard?
    public var maxres: FavoriteArtistMaxres?
}

struct FavoriteArtistResourceId: Codable {
    public var videoId: String
}
