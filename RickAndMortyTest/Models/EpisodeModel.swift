//
//  EpisodeModel.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import Foundation

struct EpisodeResponse: Codable {
    let info: PageInfo
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
}

enum CodingKeys: String, CodingKey {
    case id, name
    case airDate = "air_date"
    case episode
}
