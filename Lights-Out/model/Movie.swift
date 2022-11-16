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

// MARK: Result convenience initializers and mutators

extension Movie {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Movie.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        adult: Bool? = nil,
        backdropPath: String? = nil,
        id: Int? = nil,
        title: String?? = nil,
        originalLanguage: String? = nil,
        originalTitle: String?? = nil,
        overview: String? = nil,
        posterPath: String? = nil,
        mediaType: MediaType? = nil,
        genreIDS: [Int]? = nil,
        popularity: Double? = nil,
        releaseDate: String?? = nil,
        video: Bool?? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        name: String?? = nil,
        originalName: String?? = nil,
        firstAirDate: String?? = nil,
        originCountry: [String]?? = nil
    ) -> Movie {
        return Movie(
            adult: adult ?? self.adult,
            backdropPath: backdropPath ?? self.backdropPath,
            id: id ?? self.id,
            title: title ?? self.title,
            originalLanguage: originalLanguage ?? self.originalLanguage,
            originalTitle: originalTitle ?? self.originalTitle,
            overview: overview ?? self.overview,
            posterPath: posterPath ?? self.posterPath,
            mediaType: mediaType ?? self.mediaType,
            genreIDS: genreIDS ?? self.genreIDS,
            popularity: popularity ?? self.popularity,
            releaseDate: releaseDate ?? self.releaseDate,
            video: video ?? self.video,
            voteAverage: voteAverage ?? self.voteAverage,
            voteCount: voteCount ?? self.voteCount,
            name: name ?? self.name,
            originalName: originalName ?? self.originalName,
            firstAirDate: firstAirDate ?? self.firstAirDate,
            originCountry: originCountry ?? self.originCountry
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

enum MediaType: String, Codable, Hashable {
    case movie = "movie"
    case tv = "tv"
}
