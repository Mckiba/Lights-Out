//
//  MovieModel.swift
//  Lights-Out
//
//  Created by McKiba Williams on 12/11/22.
//

import Foundation


import Foundation

// MARK: - MovieResult
struct MovieResults: Codable, Hashable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}



// MARK: - Movie
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
        
        return Movie(adult: true, backdropPath: "/xDMIl84Qo5Tsu62c9DGWhmPI67A.jpg",
                     id: 200, title: "Black Panther: Wakanda Forever", originalLanguage: "en", originalTitle: "Black Panther: Wakanda Forever", overview: "Queen Ramonda, Shuri, M’Baku, Okoye and the Dora Milaje fight to protect their nation from intervening world powers in the wake of King T’Challa’s death. As the Wakandans strive to embrace their next chapter, the heroes must band together with the help of War Dog Nakia and Everett Ross and forge a new path for the kingdom of Wakanda.",
                     posterPath:  "/ps2oKfhY6DL3alynlSqY97gHSsg.jpg",  genreIDS: [
                        28,
                        12,
                        878
                    ], popularity: 34.076, releaseDate: nil, runtime: 125, video: false, voteAverage: 7.558, voteCount: 1292, name: nil , originalName: nil, firstAirDate: "2022-11-17", originCountry: ["DE"], genres: nil, videos: nil)
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



