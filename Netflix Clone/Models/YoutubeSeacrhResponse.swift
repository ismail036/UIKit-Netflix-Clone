//
//  YoutubeSeacrhResponse.swift
//  Netflix Clone
//
//  Created by İsmail Parlak on 21.03.2024.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [YoutubeItem]
}

struct YoutubeItem: Codable {
    let id: Id
}

struct Id: Codable {
    let kind: String
    let videoId: String?
    let channelId: String?
}
