//
//  Model.swift
//  RickAndMortyTest
//
//  Created by Akai on 18/8/23.
//

import UIKit

struct CharacterResponse: Codable {
    let info: PageInfo
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: Status
    let type: String
    let gender: Gender
    let origin: Origin
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct PageInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

struct Origin: Codable {
    let name: String
    let url: String
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

