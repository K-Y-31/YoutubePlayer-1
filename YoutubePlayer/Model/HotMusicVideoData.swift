//
//  HotMusicVideoData.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/06/13.
//

import Foundation

struct HotMusicVideo: Codable {
    public var items: [HotMusicVideoItems]
}

struct HotMusicVideoItems: Codable, Identifiable{
    public var id: String
    public var etag: String
    public var snippet: HotMusicVideoSnippet
}

struct HotMusicVideoId: Codable {
    public var kind: String
    public var videoId: String
}

struct HotMusicVideoSnippet: Codable {
    public var publishedAt: String
    public var channelId: String
    public var title: String
    public var description: String
    public var thumbnails: FavoriteArtistThumbnails
}

struct HotMusicVideoHigh: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct HotMusicVideoMedium: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct HotMusicVideotStandard: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct HotMusicVideoMaxres: Codable {
    public var url: String
    public var width: Int
    public var height: Int
}

struct HotMusicVideoThumbnails: Codable {
    public var medium: FavoriteArtistMedium?
    public var high: FavoriteArtistHigh?
    public var standard: FavoriteArtistStandard?
    public var maxres: FavoriteArtistMaxres?
}
