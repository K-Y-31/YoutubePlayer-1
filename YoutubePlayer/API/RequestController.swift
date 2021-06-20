//
//  FetchJsonData.swift
//  YoutubePlayer
//
//  Created by 木本瑛介 on 2021/05/31.
//

import Foundation
import Alamofire

protocol APIProtocol {
    var playlistid: String { get }
    var maxResults: Int { get }
    func Request<T: Codable>(type: T.Type, completion: @escaping (T) -> Void)
}

extension APIProtocol {
    func Request<T: Codable>(type: T.Type, completion : @escaping (T) -> Void) {
        let base_url = "https://www.googleapis.com/youtube/v3/playlistItems?"
        var params = [String: Any]()
        params["playlistId"] = playlistid
        params["key"] = "AIzaSyA-OgzKKEcbGri0TEC4mNNYb0d8JyeoWgs"
        params["part"] = "snippet"
        params["maxResults"] = maxResults
        let request = AF.request(base_url, method: .get, parameters: params)
        let decoder = JSONDecoder()
        request.responseJSON { (response) in
            do {
                guard let data = response.data else { return }
                let value = try decoder.decode(type.self, from: data)
                DispatchQueue.main.async {
                    completion(value)
                }
            }
            catch {
                fatalError("Failed  gettting jsondata: \(error)")
            }
        }
    }
}

class RequestAPIController: ObservableObject{
    @Published var data: [GenericVideoItems] = [GenericVideoItems]()
    @Published var artistdata: [FavoriteArtistItems] = [FavoriteArtistItems]()
    @Published var jlockdata: [JlockItems] = [JlockItems]()
    
    struct requestGeneral: APIProtocol {
        var playlistid: String = "RDCLAK5uy_nVjU2j4lOFyJicLDWEMjYmBkaejmrsx5M"
        var maxResults: Int = 20
    }
    
    struct requestArtistData: APIProtocol {
        var playlistid: String = "PLwiBGptTigOoTlKA4b54Nf45xyT_UljAn"
        var maxResults: Int = 20
    }
    
    struct requestJlockData: APIProtocol {
        var playlistid: String = "RDCLAK5uy_k-msS6PWOCGNcJo7gx0NQIPfyFzHglYEk"
        var maxResults: Int = 20
    }
}

class RequestController: ObservableObject{
    @Published var data: [GenericVideoItems] = [GenericVideoItems]()
    @Published var artistdata: [FavoriteArtistItems] = [FavoriteArtistItems]()
    @Published var jlockdata: [JlockItems] = [JlockItems]()
    @Published var hotdata: [HotMusicVideoItems] = [HotMusicVideoItems]()
    
    init() {
        Request()
        RequestArtist()
        RequestJlock()
        RequestHot()
    }
    
    func Request() {
        let base_url = "https://www.googleapis.com/youtube/v3/playlistItems?"
        var params = [String: Any]()
        params["playlistId"] = "RDCLAK5uy_nVjU2j4lOFyJicLDWEMjYmBkaejmrsx5M"
        params["key"] = "AIzaSyA-OgzKKEcbGri0TEC4mNNYb0d8JyeoWgs"
        params["part"] = "snippet"
        params["maxResults"] = 20
        let request = AF.request(base_url, method: .get, parameters: params)
        let decoder = JSONDecoder()
        request.responseJSON { (response) in
            do {
                guard let data = response.data else { return }
                let value = try decoder.decode(GenericVideoData.self, from: data)
                DispatchQueue.main.async {
                    self.data = value.items
                }
            }
            catch {
                fatalError("Failed getting data. \(error)")
            }
        }
    }
    
    func RequestArtist() {
        let base_url = "https://www.googleapis.com/youtube/v3/playlistItems?"
        var params = [String: Any]()
        params["playlistId"] = "PLwiBGptTigOoTlKA4b54Nf45xyT_UljAn"
        params["key"] = "AIzaSyA-OgzKKEcbGri0TEC4mNNYb0d8JyeoWgs"
        params["part"] = "snippet"
        params["maxResults"] = 20
        let request = AF.request(base_url, method: .get, parameters: params)
        let decoder = JSONDecoder()
        request.responseJSON { (reponse) in
            do {
                guard let data = request.data else { return }
                let value = try decoder.decode(FavoriteArtistVideo.self, from: data)
                DispatchQueue.main.async {
                    self.artistdata = value.items
                }
            }
            catch {
                fatalError("Failed Getting Data: \(error)")
            }
        }
    }
    
    func RequestJlock() {
        let base_url = "https://www.googleapis.com/youtube/v3/playlistItems?"
        var params = [String: Any]()
        params["playlistId"] = "RDCLAK5uy_k-msS6PWOCGNcJo7gx0NQIPfyFzHglYEk"
        params["key"] = "AIzaSyA-OgzKKEcbGri0TEC4mNNYb0d8JyeoWgs"
        params["part"] = "snippet"
        params["maxResults"] = 20
        let request = AF.request(base_url, method: .get, parameters: params)
        let decoder = JSONDecoder()
        request.responseJSON { (reponse) in
            do {
                guard let data = request.data else { return }
                let value = try decoder.decode(JlockVideo.self, from: data)
                DispatchQueue.main.async {
                    self.jlockdata = value.items
                }
            }
            catch {
                fatalError("Failed Getting Data: \(error)")
            }
        }
    }
    
    func RequestHot() {
        let base_url = "https://www.googleapis.com/youtube/v3/videos?"
        var params = [String: Any]()
        params["videoCategoryId"] = "10"
        params["chart"] = "mostPopular"
        params["regionCode"] = "jp"
        params["key"] = "AIzaSyA-OgzKKEcbGri0TEC4mNNYb0d8JyeoWgs"
        params["part"] = "snippet"
        params["maxResults"] = 20
        let request = AF.request(base_url, method: .get, parameters: params)
        let decoder = JSONDecoder()
        request.responseJSON { (reponse) in
            do {
                guard let data = request.data else { return }
                let value = try decoder.decode(HotMusicVideo.self, from: data)
                DispatchQueue.main.async {
                    self.hotdata = value.items
                }
            }
            catch {
                fatalError("Failed Getting Data: \(error)")
            }
        }
    }
}

