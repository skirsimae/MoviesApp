//
//  Movie.swift
//  MoviesApp
//
//  Created by SilvaKirsimae on 25/11/2019.
//  Copyright © 2019 Silva. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let results: [Results]
}

struct Results: Codable {
    let title: String
    let id: Int
    let poster_path: String
    let release_date: String
    let overview: String
}

struct Info: Codable {
    let genres: [Genres]
}

struct Genres: Codable {
    let name: String
}

struct Videos: Codable {
    let results: [Trailers]
}

struct Trailers: Codable {
    let key: String
}


