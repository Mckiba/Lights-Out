//
//  Movie.swift
//  Lights-Out
//
//  Created by McKiba Williams on 11/13/22.
//

import Foundation


// MARK: - Result
struct Movie: Codable, Hashable, Identifiable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String?
    let originalLanguage: String
    let originalTitle: String?
    let overview: String
    let posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let name: String?
    let originalName: String?
    let firstAirDate: String?
    let originCountry: [String]?
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath )")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath )")!
    }
    
    
    static func example() -> Movie {
        
        return Movie(adult: true, backdropPath: "/s1xnjbOIQtwGObPnydTebp74G2c.jpg", id: 200, title: nil, originalLanguage: "English", originalTitle: nil, overview:"Passengers on an immigrant ship traveling to the new continent get caught in a mysterious riddle when they find a second vessel adrift on the open sea.",
                     posterPath: "/2QK8tIXafyiz93PvAbKxxfK2BLb.jpg", mediaType: MediaType(rawValue: "movie")!, genreIDS: [
                        9648,
                        18
                     ], popularity: 34.076, releaseDate: nil, video: false, voteAverage: 7.128, voteCount: 90, name: "1899" , originalName: "1899", firstAirDate: "2022-11-17", originCountry: ["DE"])
    }
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case id = "id"
        case title = "title"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity = "popularity"
        case releaseDate = "release_date"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name = "name"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

enum MediaType: String, Codable, Hashable {
    case movie = "movie"
    case tv = "tv"
}

