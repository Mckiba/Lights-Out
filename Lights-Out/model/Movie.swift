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
        
        return Movie(adult: true, backdropPath: "'/s1xnjbOIQtwGObPnydTebp74G2c.jpg", id: 200, title: "Yaad Man", originalLanguage: "English", originalTitle: "YAAD TALES", overview:"Haunted by her past, a nurse travels from England to a remote Irish village in 1862 to investigate a young girl's supposedly miraculous fast.",
                     posterPath: "/npBvD1rRQHYGrxuwr2OrzXLso1w.jpg", mediaType: MediaType(rawValue: "movie")!, genreIDS: [
                        9648,
                        53
                     ], popularity: 34.076, releaseDate: "2008", video: false, voteAverage: 7.128, voteCount: 90, name: "Yaad Man" , originalName: "Yaad Man", firstAirDate: "2009", originCountry: ["Jamaica"])
                      
        
        
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

