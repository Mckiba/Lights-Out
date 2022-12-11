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
     let genreIDS: [Int]?
    let popularity: Double
    let releaseDate: String?
    let runtime: Int?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let name: String?
    let originalName: String?
    let firstAirDate: String?
    let originCountry: [String]?
    let genres: [Genre]?
    let videos: Videos?


    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath )")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath )")!
    }
    
    struct Genre: Codable, Hashable {
        let id: Int
        let name: String

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
        }
    }
    
    struct Videos: Codable, Hashable {
        let results: [Result]

        enum CodingKeys: String, CodingKey {
            case results = "results"
        }
    }
    
    struct Result: Codable, Hashable {
        let iso639_1: String
        let iso3166_1: String
        let name: String
        let key: String
        let site: String
        let size: Int
        let type: String
        let official: Bool
        let publishedAt: String
        let id: String

        enum CodingKeys: String, CodingKey {
            case iso639_1 = "iso_639_1"
            case iso3166_1 = "iso_3166_1"
            case name = "name"
            case key = "key"
            case site = "site"
            case size = "size"
            case type = "type"
            case official = "official"
            case publishedAt = "published_at"
            case id = "id"
        }
    }
    
    static func example() -> Movie {

        return Movie(adult: true, backdropPath: "/duIsyybgrC4S8kcCIVaxNOttV15.jpg" , id: 200, title: "Troll", originalLanguage: "English", originalTitle: "Troll", overview:"Deep inside the mountain of Dovre, something gigantic awakens after being trapped for a thousand years. Destroying everything in its path, the creature is fast approaching the capital of Norway. But how do you stop something you thought only existed in Norwegian folklore?",
                     posterPath: "/9z4jRr43JdtU66P0iy8h18OyLql.jpg",  genreIDS: [
                        9648,
                        18
                     ], popularity: 34.076, releaseDate: nil, runtime: 125, video: false, voteAverage: 7.128, voteCount: 90, name: "Troll" , originalName: "Troll", firstAirDate: "2022-11-17", originCountry: ["DE"], genres: nil, videos: nil)
    }
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case id = "id"
        case title = "title"
        case genres = "genres"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
         case genreIDS = "genre_ids"
        case popularity = "popularity"
        case releaseDate = "release_date"
        case runtime = "runtime"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name = "name"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case videos = "videos"
    }
}

enum MediaType: String, Codable, Hashable {
    case movie = "movie"
    case tv = "tv"
}
