//
//  Search.swift
//  MovieApp
//
//  Created by T65713 on 9.03.2023.
//

import Foundation
struct SearchResult: Codable {
    let search: [MovieInfo]
    let totalResults, response: String
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct MovieInfo: Codable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}
