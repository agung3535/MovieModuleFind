//
//  File.swift
//  
//
//  Created by Putra on 16/06/22.
//

import Foundation



public struct MovieModuleResponse: Codable {
    public let dates: DatesModule?
    public let page: Int?
    public let results: [MovieModuleListResult]?
    public let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct DatesModule: Codable {
   public let maximum, minimum: String?
}

public struct MovieModuleListResult: Codable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDS: [Int]?
    public let id: Int?
    public let originalLanguage: String?
    public let originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
