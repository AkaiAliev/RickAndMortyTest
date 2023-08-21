//
//  LocationModel.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import Foundation

struct LocationResponse: Codable {
    let info: PageInfo
    let results: [Location]
}

struct Location: Codable {
    let id: Int
    let name: String
    let type, dimension: String
    let residents: [String]
    let url: String
}


